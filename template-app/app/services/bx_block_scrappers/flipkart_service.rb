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
        csv_headers = ["Images"]
        CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |writer|
            @base_urls.each do |base_url|
            details = []
            if is_valid_url? base_url
              html = HTTParty.get(base_url,headers: headers)
              deep_link = Nokogiri::HTML(html.body).search('div._1vhGDP')
              deep_link.each do |children|
                children.children.each do |value|
                  obj_id = value.values.last
                  deep_html = HTTParty.get(base_url+obj_id,headers: headers)
                  link = Nokogiri::HTML(deep_html.body).search('img._396cs4')
                  link.each do |images_url|
                    details << images_url.attributes["src"].value
                  end
                end
              end
              # details = parsed_page.css('img._396cs4').map{|a| a.attributes['src'].value}.compact
            end
            details.each do |image|
              writer << [ image ]
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
  end
end