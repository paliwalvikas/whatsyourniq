module BxBlockScrappers
  class AmazonService
    attr_accessor :headers, :base_url, :append_url
    require 'csv'
    require 'google/cloud/vision'
    require 'google/cloud/vision/v1/image_annotator'  

    ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "#{Rails.root}/lib/key.json"
    
    def initialize
      append_url = "https://www.amazon.in/"
      headers = {
        'Connection': 'keep-alive',
        'Pragma': 'no-cache',
        'Cache-Control': 'no-cache',
        'DNT': '1',
        'Upgrade-Insecure-Requests': '1',
        # You may want to change the user agent if you get blocked
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.80 Safari/537.36',
        'Referer': append_url,
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
          products = parsed_page.css('a.acs-product-block__product-title')
          products.each do |product|
            detail_url = append_url + product.attributes['href'].value rescue nil
            get_detail(detail_url,value)
            value[:product].uniq.each do |p|
              html = HTTParty.get(append_url+p,headers: headers)
              parsed_page = Nokogiri::HTML(html.body)
              weight_and_brand(parsed_page, value)
              value = {}
              csv << [value[:image].compact.uniq , value[:brand], value[:weight] ]
            end
          end
        end
      else
        return false
      end
    end

    def get_detail(url, value)
      if is_valid_url? url
        link , value[:product] = [],[]
        html = HTTParty.get(url,headers: headers)
        parsed_page = Nokogiri::HTML(html.body).search('a.a-color-base')
        (2..parsed_page.length-1).each do |i| link << parsed_page[i].attributes['href'].value end
        (1..link.length-1).each do |a|
          html = HTTParty.get((append_url+link[a]),headers: headers)
          parsed_page = Nokogiri::HTML(html.body).search('a.a-link-normal').map{ |i| value[:product] << i.attributes['href'].value}
        end
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



    def weight_and_brand(parsed_page, value)
      value[:image] = []
      parsed_page.search('img.a-dynamic-image').map{ |i| value[:image] << i['src']}
      a = parsed_page.css('div.a-spacing-small').map { |a| a.children.text }
      filter = a.map{|p| p if  p.include?("Brand")}
      filter.split("       ").each do |i|
        value[:brand] = i.slice!("Brand") if i.include?("Brand")
        value[:weight] = i if i.include?("Weight") || i.include?("Package Weight")
      end if filter.present?
      price(parsed_page,value)
    end

    def price parsed_page
      price = parsed_page.css("div.offersConsistencyEnabled").map{|a| a.children.text}
      text = price.map{|u| u if u.include?("M.R.P.")}
      text.split("          ").each do |p|
        value[:price] = p if p.include?("M.R.P.")
        value[:selling_p] = p if p.include?("Deal of the Day") 
      end if text.present?
    end

    def img_url_to_src(link)
      q = []
      link.each do |l|
        html = HTTParty.get((append_url+l),headers: headers)
        parsed_page = Nokogiri::HTML(html.body)
        parsed_page.css('a.a-link-normal').map{ |u| q << u['href']}
      end
      last(q)
    end

    def last link
      src = []
      link.each do |l|
        html = HTTParty.get((append_url+l),headers: headers)
        parsed_page = Nokogiri::HTML(html.body)
        parsed_page.css('img.a-dynamic-image').map{|p| src << p.values[1]}
      end
      src.uniq
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
  end
end
              # img = parsed_page.search('ul.a-unordered-list').search('li.image')[0].search('img').first['src']
            # if detail_url
            #   @src.uniq
            #   @src.collect do |i|
            #     csv << [i , @brand, @weight]
            #   end
            # end