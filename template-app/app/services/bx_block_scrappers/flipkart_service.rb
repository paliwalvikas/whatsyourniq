module BxBlockScrappers
  require 'nokogiri'
  require 'pp'
  class FlipkartService
    attr_accessor :headers, :base_urls, :append_url
    ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "#{Rails.root}/lib/key.json"
    
    def initialize
       @append_url = "https://www.flipkart.com/"
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

        @base_urls = BxBlockScrappers::UrlService.new.url
    end

      def scrap_data
        file = "#{Rails.root}/public/flipkart.csv"
        csv_headers = ['Images', 'Brand','Product name','Weight','MRP','Price Post Discount','Product Type','Category','Ingredients']
        CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |writer|
            @base_urls.each do |base_url|
            if is_valid_url? base_url
              html = HTTParty.get(base_url,headers: headers)
              deep_link = Nokogiri::HTML(html.body).search('div._1vhGDP')
              deep_link.each do |children|
                children.children.each do |value|
                  obj_id = value.values.last
                  deep_html = HTTParty.get(base_url+obj_id,headers: headers)
                  link = Nokogiri::HTML(deep_html.body)
                  get_product_info(link)
                  writer << [@img, @brand, @p_name, @weight, @mrp, @price_p_dis, @p_type, @category,@ingredient]

                end
              end
            end
                  # link.each do |images_url|
                  #   writer << [images_url.attributes["src"].value , images_url.attributes["alt"].value]
                  # end
            # details.each do |image|
            #   writer << [ image ]
            # end
          end
        end
      end

     private

      def is_valid_url? url
        uri = URI.parse url
        uri.kind_of? URI::HTTP
      rescue URI::InvalidURIError
        false
      end
    
      def get_detail(sku)
        html = HTTParty.get("#{append_url}pd/#{sku}", headers: headers)
        parsed_page = Nokogiri::HTML(html.body)
      end

      def get_product_info link
        @img = []
        @p_name = link.search('span.B_NuCI').text
        @price_p_dis = link.search('div._25b18c').children.first.text
        @mrp = link.search('div._25b18c').children[1].text
        link.search('img.q6DClP').map{|i| @img << i.attributes['src'].value}
        link.search('tr.row').each do |val|
          text = val.text
          @pack_of = value(text, 'pack_of') if text.include?('Pack of') 
          @brand = value(text, 'brand') if text.include?('Brand')
          @weight = value(text,'Quantity') if text.include?('Quantity')
          @p_type = value(text, 'Type') if text.include?('Type')
          @ingredient = value(text, 'Ingredients') if text.include?('Ingredients')
          @p_category = value(text,'Container Type') if text.include?('Container Type')
        end 
      end

      def value(text,str)
        text.slice!(str)
        text
      end
  end
end