module BxBlockScrappers
  class AmazonService
    attr_accessor :headers, :base_url, :append_url
    require 'csv'
    require 'google/cloud/vision'
    require 'google/cloud/vision/v1/image_annotator'  

    ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "#{Rails.root}/lib/key.json"
    
    def initialize
      @append_url = "https://www.amazon.in/"
      @headers = {
        'Connection': 'keep-alive',
        'Pragma': 'no-cache',
        'Cache-Control': 'no-cache',
        'DNT': '1',
        'Upgrade-Insecure-Requests': '1',
        # You may want to change the user agent if you get blocked
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.80 Safari/537.36',
        'Referer': @append_url,
        'Accept-Language': 'en-GB,en-US;q=0.9,en;q=0.8'
      }
      @base_url = "https://www.amazon.in/Gourmet-Specialty-Foods/b/?ie=UTF8&node=2454178031&ref_=nav_cs_grocery"
    end

    def scrap_data
      if is_valid_url? @base_url
        file = "#{Rails.root}/public/amazon.csv"
        csv_headers = ['images','Brand','Weight']
        CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |csv|
          html = HTTParty.get(@base_url,headers: headers)
          parsed_page = Nokogiri::HTML(html.body)
          u = parsed_page.css('ul.a-unordered-list').first.css('li.a-spacing-micro').css('a.a-link-normal').map{|i| i['href']}
          # products = parsed_page.css('a.acs-product-block__product-title')
          u.each do |product|
            detail_url = append_url + product rescue nil #.attributes['href'].value rescue nil
            get_detail(detail_url)
            if detail_url
              @src.uniq
              @src.collect do |i|
                csv << [i] #, @brand, @weight]
              end
            end
          end
        end
      else
        return false
      end
    end

    def get_detail url
      if is_valid_url? url
        html = HTTParty.get(url,headers: headers)
        parsed_page = Nokogiri::HTML(html.body)
        link = []
        x = parsed_page.css('a.a-color-base')
        (2..x.length-1).each do |i| link << x[i].values[1] end
        img_url_to_src(link.uniq)
        # h = Hash.new{[]}
        # parsed_page.css("ul.regularAltImageViewLayout").children.map{|i| @src << eval(i.children.children[1].css("img").to_json).flatten.last if i.children.children[1].present?}
        # h[:images] = parsed_page.css("img.a-dynamic-image").map{|a| a.attributes['src'].value}.compact
        # parsed_page.css("ul.regularAltImageViewLayout")[0].children[1].children.children[1].css("img").to_json
        # amazon_data_from_images(h[:images], parsed_page)
        # @src = h[:images]
        # weight_and_brand(parsed_page)
        # @src = []
        # parsed_page.css('img.s-image').map{ |i| @src << i['srcset']}
        # @src.compact
      else
        nil
      end
    end

    private

    def is_valid_url? url
      uri = URI.parse url
      uri.kind_of? URI::HTTP
    rescue URI::InvalidURIError
      false
    end

    def img_url_to_src(link)
      @q = []
      link.each do |l|
        html = HTTParty.get((append_url+l),headers: headers)
        parsed_page = Nokogiri::HTML(html.body)
        parsed_page.css('a.a-link-normal').map{ |u| @q << u['href']}
      end
      last(@q)
    end

    def last link
        @src = []
      link.each do |l|
        html = HTTParty.get((append_url+l),headers: headers)
        parsed_page = Nokogiri::HTML(html.body)
        parsed_page.css('img.a-dynamic-image').map{|p| @src << p.values[1]}
      end
      @src.uniq
    end

    # def amazon_data_from_images(image, parsed_page)
    #   nut = []
    #   @src = []
    #   @ingredient = ''
    #   image.each do |img|
    #     image_annotator = Google::Cloud::Vision::V1::ImageAnnotator::Client.new
    #     response = image_annotator.document_text_detection image: img
    #     response.responses.each do |res|
    #       next unless res.text_annotations.present?
        
    #       des = res.text_annotations.first.description
    #       if des.include?('NUTRITION') || des.include?('Nutrition')
    #         nut << des
    #         @src << img
    #       elsif des.include?('Ingredients') || des.include?('INGREDIENTS')
    #         @ingredient = des.squish
    #         @src << img
    #       end
    #     end
    #   end
    #   weight_and_brand(parsed_page)
    #   # nutrition = nut.present? ? nutritional_values(nut) : filter_ingradiant(parsed_page)
    #   @src = @src.present? ? @src : image
    #   # [src.uniq, nutrition, ingredient]
    # end

    def weight_and_brand parsed_page
      a = parsed_page.css('div.a-spacing-small').map { |a| a.children.text }
      a.map{|a| @w = a if  a.include?("Brand")}
      @w.split("       ").each do |i|
        @brand = i.slice!("Brand") if i.include?("Brand")
        @weight = i if i.include?("Weight") || i.include?("Package Weight")
      end
      price(parsed_page)
    end

    def price parsed_page
      price = parsed_page.css("div.offersConsistencyEnabled").map{|a| a.children.text}
      price.map{|u| @p = u if u.include?("M.R.P.")}
      @p.split("          ").each do |p|
        @price = p if p.include?("M.R.P.")
        @selling_p = p if p.include?("Deal of the Day") 
      end
    end

  end
end