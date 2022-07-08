module BxBlockScrappers
  require 'nokogiri'
  require 'pp'
  class FlipkartService
    attr_accessor :headers, :base_urls, :append_url
    ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "#{Rails.root}/lib/key.json"
    
    def initialize
       append_url = "https://www.flipkart.com/"
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

        @base_urls = BxBlockScrappers::UrlService.new.flipkart_url
    end

      def scrap_data
        file = "#{Rails.root}/public/flipkart.csv"
        csv_headers = ['Images', 'Brand','Product name','Weight','MRP','Price Post Discount','Product Type','Category','Ingredients','Nutritional Facts']
        CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |writer|
            @base_urls.each do |base_url|
            if is_valid_url? base_url
              (0..5).each do |page|
                html = HTTParty.get(base_url,headers: headers) if page == 0
                html = HTTParty.get("#{base_url}&page=#{page}",headers: headers) unless page == 0
                deep_link = Nokogiri::HTML(html.body).search('div._1vhGDP')
                deep_link.each do |children|
                    value = {}
                    obj_id = children.children.first.attributes['href'].value #value.values.last
                    next unless obj_id.present?
                    link = BxBlockScrappers::UrlService.new.http_noko(base_url+obj_id, @headers) 
                    get_product_info(link, value)
                    writer << [value[:img], value[:brand], value[:p_name], value[:weight], value[:mrp], value[:price_p_dis], value[:p_type], value[:category], value[:ingredient], value[:nutrition] ]
                end
              end
            end
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
    

      def get_product_info(link, value)
        value[:img] = []
        value[:p_name] = link.search('span.B_NuCI').text
        aa = link.search('div._25b18c').children
        value[:price_p_dis] = aa[0].text if aa[0].present?
        value[:mrp] = aa[1].text if aa[1].present?
        link.search('img.q6DClP').map{|i| value[:img] << i.attributes['src'].value}
        link.search('tr.row').each do |val|
          text = val.text
          value[:pack_of] = value(text, 'pack_of') if text.include?('Pack of') 
          value[:brand] = value(text, 'brand') if text.include?('Brand')
          value[:weight] = value(text,'Quantity') if text.include?('Quantity')
          value[:p_type] = value(text, 'Type') if text.include?('Type')
          value[:ingredient] = value(text, 'Ingredients') if text.include?('Ingredients')
          value[:p_category] = value(text,'Container Type') if text.include?('Container Type')
          value[:nutrition] = value(text,'Nutrient Content') if text.include?('Nutrient Content')
        end 
        # @nutrition == 'NA' || @nutrition.nil? ? @nutrition : filter_nutrition(@nutrition) 
      end

      def value(text,str)
        text.slice!(str)
        text
      end

      def filter_nutrition(nut)
        nut = nut.split(',')
      end
  end
end


    # def http_party_nokogiri(link)
    #   doc = HTTParty.get(link ,headers: headers)
    #   parsed_page = Nokogiri::HTML(doc.body)
    # end
      # def get_detail(sku)
      #   html = HTTParty.get("#{append_url}pd/#{sku}", headers: headers)
      #   parsed_page = Nokogiri::HTML(html.body)
      # end