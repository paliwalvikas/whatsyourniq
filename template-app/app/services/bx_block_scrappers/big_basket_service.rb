module BxBlockScrappers
  class BigBasketService
    attr_accessor :headers, :base_url, :append_url
    
    require "google/cloud/vision"
    require "google/cloud/vision/v1/image_annotator"

    def initialize
      @append_url = "https://www.bigbasket.com/"
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
          'Accept-Language': 'en-GB,en-US;q=0.9,en;q=0.8',
      }

     @base_url = "#{@append_url}product/get-products/?slug=bakery-cakes-dairy&tab_type=[%22all%22]&sorted_on=popularity&listtype=pc"
    end

    def scrap_data
      if is_valid_url? base_url
        file = "#{Rails.root}/public/basket.csv"
        csv_headers = [ "Image", "Brand", "Weight", "Product Name", "Price", "Price Post Discount", "Product Description","Nutritional Information", "Ingredient List","Nutritional Table for per 100gm/100ml/any other","Energy","Fibers","Proteins", "Vitamin A", "Vitamin C","Vitamin D","Vitamin B6","Vitamin B12","Folate","Calcium","Iron","Iodine","Calories","Total Fat","Saturated Fat", "Monounsaturated Fat","Ployunsaturated Fat","Trans Fatty Acid","Cholesterol", "Sodium","Sugar",'Magnesium', 'Zinc', 'Lodine','Phosphorus', 'Potassium','Riboflavin','Carbohydrate','Fat', 'Total Sugars']
        CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |csv|
          (2..4).each do |page|
            resp = HTTParty.get(base_url + "&page=#{page}",headers: headers)
            skus = resp["tab_info"]["product_map"]["all"]["prods"].each do |a|
              values = get_detail(a['sku'])
              values_filter(values)
              csv << [values[0][0],a['p_brand'], a['w'], a['pc_n'], a['mrp'], a['sp'], a['p_desc'], values[0][1], values[0][2],@per,@energy,@Fiber,@Proteins, @vitA , @vitC , @vitD , @vitB6 , @vitB12 , @Folate , @calcium , @iron , @iodine , @calories , @totalFat , @saturated , @monounsaturated , @ployunsaturated , @TransFA , @cholesterol , @sodium, @sugar, @magnesium , @zinc , @lodine , @phosphorus , @potassium , @riboflavin , @carbohydrate , @fat , @totalSugars]
            end
          end
        end
      else
        return false
      end
    end

    def get_detail sku
      html = HTTParty.get("#{append_url}pd/#{sku}",headers: headers)
      parsed_page = Nokogiri::HTML(html.body)
      # i = filter_ingradiant(parsed_page)
      i = google_fetch_data(parsed_page.css("img._3oKVV").map{|a| a.attributes['src'].value}.compact.uniq, parsed_page)
      return [i] rescue [] #parsed_page.css("img._3oKVV").map{|a| a.attributes['src'].value}.compact, i
    end
    
    private

    def is_valid_url? url
      uri = URI.parse url
      uri.kind_of? URI::HTTP
    rescue URI::InvalidURIError
      false
    end

    def values_filter(values)
      @per,@energy,@Fiber,@proteins,@vitA, @vitC, @vitD, @vitB6, @vitB12, @Folate, @calcium, @iron, @iodine, @calories, @totalFat, @saturated, @monounsaturated, @ployunsaturated, @TransFA, @sodium,@sugar,@magnesium, @zinc, @lodine,@phosphorus, @potassium,@riboflavin,@carbohydrate,@fat, @totalSugars = ""
      for a in 0..values[0][1].length-1 do
        val = values[0][1][a]
        @per = val if val.include?("Per") || val.include?("PER")
        @energy = val if val.include?("Energy") || val.include?("ENERGY")
        @Fiber = val if val.include?("Fiber") || val.include?("FIBER")
        @proteins = val if val.include?("Protein") || val.include?("PROTEIN")
        @vitA = val if val.include?("Vitamin A") || val.include?("VITAMIN A") || val.include?("VITAMIN-A") || val.include?("Vitamin-A")
        @vitC = val if val.include?("Vitamin C") || val.include?("VITAMIN C") || val.include?("VITAMIN-C") || val.include?("Vitamin-C")
        @vitD = val if val.include?("Vitamin D") || val.include?("VITAMIN D") || val.include?("VITAMIN-D") || val.include?("Vitamin-D") 
        @vitB6 = val if val.include?("Vitamin B6") || val.include?("VITAMIN B6") || val.include?("VITAMIN-B6") || val.include?("Vitamin-B6")
        @vitB12 = val if val.include?("Vitamin B12") || val.include?("VITAMIN B12") || val.include?("VITAMIN-B12") || val.include?("Vitamin-B12")
        @Folate = val if val.include?("Folate") || val.include?("FOLATE") 
        @calcium = val if val.include?("Calcium") || val.include?("CALCIUM")
        @iron = val if val.include?("Iron") || val.include?("IRON")  
        @iodine = val if val.include?("Iodine") || val.include?("IODINE")
        @calories = val if val.include?("Calories") || val.include?("CALORIES") 
        @totalFat = val if val.include?("Total Fat") || val.include?("TOTAL FAT") 
        @saturated = val if val.include?("Saturated") || val.include?("SATURATED") 
        @monounsaturated = val if val.include?("Monounsaturated Fat") || val.include?("MONOUNSATURATED FAT")
        @ployunsaturated = val if val.include?("Ployunsaturated Fat") || val.include?("PLOYUNSATURATED FAT")
        @TransFA = val if val.include?("Trans") || val.include?("TRANSH")
        @sodium = val if val.include?("Sodium") || val.include?("SODIUM")
        @sugar = val if val.include?("Sugar") || val.include?("SUGAR")
        @magnesium = val if val.include?("Magnesium")
        @zinc = val if val.include?("Zinc") || val.include?("ZINC")
        @lodine =  val if val.include?("Lodine") || val.include?("LODINE")
        @phosphorus = val if val.include?("Phosphorus") || val.include?("PHOSPHORUS")
        @potassium = val if val.include?("Potassium") || val.include?("POTASSIUM")
        @riboflavin = val if val.include?("Riboflavin") || val.include?("RIBOFLAVIN")
        @carbohydrate = val if val.include?("Carbohydrate") || val.include?("CARBOHYDRATE")
        @fat = val if val.include?("Fat") || val.include?("Fat")
        @totalSugars = val if val.include?("Total Sugar") || val.include?("TOTAL SUGAR")
        @cholesterol = val if val.include?("Cholesterol") || val.include?("CHOLESTEROL")
      end
    end

    def filter_ingradiant(parsed_page)
      a = parsed_page.css("div._2fn-7").map{|a| a.children.text}
      a.each{|p|  @nutrition = p if p.include? "Nutritional Information"}
      if  @nutrition.present? 
        @nutrition.slice! "Nutritional Information:" if @nutrition.class == String
        @nutrition = @nutrition.split(':').split(',').flatten 
      end
      parsed_page.css("div._26MFu").map{ |i|  @nutrition = i.children.children.text if  i.children.children.text.include? "Nutritional"} if !@nutrition.present?
      parsed_page.css("div._3ezVU").map{|i| @ingredient = i.children.text if i.children.text.include?"Ingredients" }
      if @ingredient.present? 
        @ingredient.slice! "Ingredients" 
        @ingredient = @ingredient.strip 
      end
      [@nutrition,@ingredient]
    end


    def google_fetch_data(image, parsed_page)
      src , nut, ingredient = [],[],''
      image.each do |img|
        image_annotator = Google::Cloud::Vision::V1::ImageAnnotator::Client.new
        response =image_annotator.document_text_detection image: img
        response.responses.each do |res|
          if res.text_annotations.present?
            des = res.text_annotations.first.description 
            if des.include?("NUTRITION") || des.include?("Nutrition")
              nut << des 
              src << img
            elsif des.include?("Ingredients") || des.include?("INGREDIENTS") 
              ingredient = des.squish
              src << img
            end
          end
        end
      end
      nutrition =  nut.present?  ? nutritional_values(nut) : nut
      [src.uniq, nutrition, ingredient]
    end

    def nutritional_values(nutrition)
      keys =  ['Per','Energy','Fiber', 'Protein', 'Vitamin A', 'Vitamin C', 'Vitamin D', 'Vitamin B6', 'Vitamin B12', 'Folate', 'Calcium', 'Iron','Iodine','Calories','Total Fat','Saturated','Monounsaturated Fat', 'Ployunsaturated Fat','Trans Fatty Acid','Cholesterol','Sodium','Sugar','Magnesium', 'Zinc', 'Lodine','Phosphorus', 'Potassium','Riboflavin','Carbohydrate','Fat', 'Total Sugars',  'Vitamin-A','Vitamin-C','Vitamin-D','Vitamin-B6', 'Vitamin-B12' ]
      keys << keys.map{|i| i.upcase}
        col = []
        for c in 0..nutrition.length-1 do  
          d = nutrition[c].split
          for a in 0..keys.length-1 do 
            if d.index(keys[a]).present?
              ing = d.slice(d.index(keys[a]))
              val = d.slice(d.index(keys[a])+ 1)
              val1 = d.slice(d.index(keys[a])+ 2)
              val2 = d.slice(d.index(keys[a])+ 2)

              col<< [ing,val,val1,val2]
            end
          end   
          puts "----------------------Next_Value-------------------------"
        end 
        col
    end

  end
end

      # @x.split(',')
      # xxx = xx.split(',').first.strip()
      # xxx.slice! "Nutritional Information:"
      # xxx

