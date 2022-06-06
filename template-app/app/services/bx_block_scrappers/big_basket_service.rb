module BxBlockScrappers
  class BigBasketService
    attr_accessor :headers, :base_url, :append_url

    require 'google/cloud/vision'
    require 'google/cloud/vision/v1/image_annotator'

    def initialize
      @append_url = 'https://www.bigbasket.com/'
      @headers = {
        'Connection': 'keep-alive',
        'Pragma': 'no-cache',
        'Cache-Control': 'no-cache',
        'DNT': '1',
        'Upgrade-Insecure-Requests': '1',
        # You may want to change the user agent if you get blocked
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.113 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,/;q=0.8,application/signed-exchange;v=b3;q=0.9',
        'Origin': @append_url,
        'Referer': @append_url,
        'Accept-Language': 'en-GB,en-US;q=0.9,en;q=0.8'
      }

      @base_url = "#{@append_url}product/get-products/?slug=bakery-cakes-dairy&tab_type=[%22all%22]&sorted_on=popularity&listtype=pc"
    end

    def scrap_data
      if valid_url? base_url
        file = "#{Rails.root}/public/basket.csv"
        csv_headers = ['Image', 'Brand', 'Weight', 'Product Name', 'Price', 'Price Post Discount',
                       'Product Description', 'Nutritional Information', 'Ingredient List', 'Nutritional Table for per 100gm/100ml/any other', 'Energy', 'Fibers', 'Proteins', 'Vitamin A', 'Vitamin C', 'Vitamin D', 'Vitamin B6', 'Vitamin B12', 'Folate', 'Calcium', 'Iron', 'Iodine', 'Calories', 'Total Fat', 'Saturated Fat', 'Monounsaturated Fat', 'Ployunsaturated Fat', 'Trans Fatty Acid', 'Cholesterol', 'Sodium', 'Sugar', 'Magnesium', 'Zinc', 'Lodine', 'Phosphorus', 'Potassium', 'Riboflavin', 'Carbohydrate', 'Fat', 'Total Sugars']
        CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |csv|
          (2..4).each do |page|
            resp = HTTParty.get(base_url + "&page=#{page}", headers: headers)
            resp['tab_info']['product_map']['all']['prods'].each do |a|
              values = get_detail(a['sku'])
              values_filter(values) if values[0][1].present?
              csv << [values[0][0], a['p_brand'], a['w'], a['pc_n'], a['mrp'], a['sp'], a['p_desc'], values[0][1],
                      values[0][2], @per, @energy, @fiber, @Proteins, @vitA, @vitC, @vitD, @vitB6, @vitB12, @folate, @calcium, @iron, @iodine, @calories, @total_fat, @saturated, @monounsaturated, @ployunsaturated, @trans_fa, @cholesterol, @sodium, @sugar, @magnesium, @zinc, @lodine, @phosphorus, @potassium, @riboflavin, @carbohydrate, @fat, @total_sugars]
            end
          end
        end
      else
        false
      end
    end

    def get_detail(sku)
      html = HTTParty.get("#{append_url}pd/#{sku}", headers: headers)
      parsed_page = Nokogiri::HTML(html.body)
      i = google_fetch_data(parsed_page.css('img._3oKVV').map do |a|
                              a.attributes['src'].value
                            end.compact.uniq, parsed_page)
      begin
        [i]
      rescue StandardError
        []
      end
    end

    private

    def valid_url?(url)
      uri = URI.parse url
      uri.is_a? URI::HTTP
    rescue URI::InvalidURIError
      false
    end

    def values_filter(values)
      @per, @energy, @fiber, @proteins, @vitA, @vitC, @vitD, @vitB6, @vitB12, @folate, @calcium, @iron, @iodine, @calories, @total_fat, @saturated, @monounsaturated, @ployunsaturated, @trans_fa, @sodium, @sugar, @magnesium, @zinc, @lodine, @phosphorus, @potassium, @riboflavin, @carbohydrate, @fat, @total_sugars = ''
      (0..values[0][1].length - 1).each do |a|
        val = values[0][1][a]
        p = val.map { |a| a.squish.pluralize(2).upcase if a.present? }
        @per = val if p.include?('PERS')
        @energy = val if p.include?('ENERGIES')
        @fiber = val if p.include?('FIBERS')
        @proteins = val if p.include?('PROTEINS')
        @vitA = val if p.include?('VITAMIN AS') || p.include?('VITAMIN-AS')
        @vitC = val if p.include?('VITAMIN CS') || p.include?('VITAMIN-CS')
        @vitD = val if p.include?('VITAMIN DS') || p.include?('VITAMIN-DS')
        @vitB6 = val if p.include?('VITAMIN B6S') || p.include?('VITAMIN-B6S')
        @vitB12 = val if p.include?('VITAMIN B12S') || p.include?('VITAMIN-B12S')
        @folate = val if p.include?('FOLATES')
        @calcium = val if p.include?('CALCIA')
        @iron = val if p.include?('IRONS')
        @iodine = val if p.include?('IODINES')
        @calories = val if p.include?('CALORIES')
        @total_fat = val if p.include?('TOTAL FATS')
        @saturated = val if p.include?('SATURATEDS')
        @monounsaturated = val if p.include?('MONOUNSATURATED FATS')
        @ployunsaturated = val if p.include?('PLOYUNSATURATED FATS')
        @trans_fa = val if p.include?('TRANSHES')
        @sodium = val if p.include?('SODIA')
        @sugar = val if p.include?('SUGARS')
        @magnesium = val if p.include?('MAGNESIA')
        @zinc = val if p.include?('ZINCS')
        @lodine = val if p.include?('LODINES')
        @phosphorus = val if p.include?('PHOSPHORUS')
        @potassium = val if p.include?('POTASSIA')
        @riboflavin = val if p.include?('RIBOFLAVINS')
        @carbohydrate = val if p.include?('CARBOHYDRATES')
        @fat = val if p.include?('FATS')
        @total_sugars = val if p.include?('TOTAL SUGARS')
        @cholesterol = val if p.include?('CHOLESTEROLS')
      end
    end

    def filter_ingradiant(parsed_page)
      a = parsed_page.css('div._2fn-7').map { |a| a.children.text }
      a.each { |p| @nutrition = p if p.include? 'Nutritional Information' }
      if @nutrition.present?
        @nutrition.slice! 'Nutritional Information:' if @nutrition.instance_of?(String)
        @nutrition = @nutrition.split(':').split(',').flatten
      end
      unless @nutrition.present?
        parsed_page.css('div._26MFu').map do |i|
          @nutrition = i.children.children.text if i.children.children.text.include? 'Nutritional'
        end
      end
      @nutrition.present? ? nutritional_values([@nutrition]) : @nutrition
    end

    def google_fetch_data(image, parsed_page)
      nut = []
      src = []
      ingredient = ''
      image.each do |img|
        image_annotator = Google::Cloud::Vision::V1::ImageAnnotator::Client.new
        response = image_annotator.document_text_detection image: img
        response.responses.each do |res|
          next unless res.text_annotations.present?

          des = res.text_annotations.first.description
          if des.include?('NUTRITION') || des.include?('Nutrition')
            nut << des
            src << img
          elsif des.include?('Ingredients') || des.include?('INGREDIENTS')
            ingredient = des.squish
            src << img
          end
        end
      end
      nutrition = nut.present? ? nutritional_values(nut) : filter_ingradiant(parsed_page)
      src = src.present? ? src : image-[image[0]]
      [src.uniq, nutrition, ingredient]
    end

    def nutritional_values(nutrition)
      keys =  ['Per', 'Energy', 'Fiber', 'Protein', 'Vitamin A', 'Vitamin C', 'Vitamin D', 'Vitamin B6', 'Vitamin B12',
               'Folate', 'Calcium', 'Iron', 'Iodine', 'Calories', 'Total Fat', 'Saturated', 'Monounsaturated Fat', 'Ployunsaturated Fat', 'Trans Fatty Acid', 'Cholesterol', 'Sodium', 'Sugar', 'Magnesium', 'Zinc', 'Lodine', 'Phosphorus', 'Potassium', 'Riboflavin', 'Carbohydrate', 'Fat', 'Total Sugars', 'Vitamin-A', 'Vitamin-C', 'Vitamin-D', 'Vitamin-B6', 'Vitamin-B12']
      keys << keys.map(&:upcase)
      keys = keys.flatten
      col = []
      (0..nutrition.length - 1).each do |c|
        d = nutrition[c].split
        (0..keys.length - 1).each do |a|
          next unless d.index(keys[a]).present?

          ing = d.slice(d.index(keys[a]))
          val = d.slice(d.index(keys[a]) + 1)
          val1 = d.slice(d.index(keys[a]) + 2)
          val2 = d.slice(d.index(keys[a]) + 2)

          col << [ing, val, val1, val2]
        end
        puts '----------------------Next_Value-------------------------'
      end
      col
    end
  end
end

# @x.split(',')
# xxx = xx.split(',').first.strip()
# xxx.slice! "Nutritional Information:"
# xxx
# puts @per, @energy, @fiber, @proteins, @vitA, @vitC, @vitD, @vitB6, @vitB12, @folate, @calcium, @iron, @iodine, @calories, @total_fat, @saturated, @monounsaturated, @ployunsaturated, @trans_fa, @sodium, @sugar, @magnesium, @zinc, @lodine, @phosphorus, @potassium, @riboflavin, @carbohydrate, @fat, @total_sugars
      # parsed_page.css('div._3ezVU').map { |i| @ingredient = i.children.text if i.children.text.include? 'Ingredients' }
      # if @ingredient.present?
      #   @ingredient.slice! 'Ingredients'
      #   @ingredient = @ingredient.strip
      # end
    # i = filter_ingradiant(parsed_page)
    # parsed_page.css("img._3oKVV").map{|a| a.attributes['src'].value}.compact, i