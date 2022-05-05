module BxBlockScrappers  
  class JiomartService
    attr_accessor :headers, :base_url, :append_url
    
    def initialize
       @append_url = "https://www.jiomart.com/"
        @headers = {
          'Connection': 'keep-alive',
          'Pragma': 'no-cache',
          'Cache-Control': 'no-cache',
          'DNT': '1',
          'Upgrade-Insecure-Requests': '1',
          # You may want to change the user agent if you get blocked
          'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.80 Safari/537.36',
          'Referer': @append_url,
          'Origin': @append_url,
          'Access-Control-Allow-Origin': @append_url,
          'Accept-Language': 'en-GB,en-US;q=0.9,en;q=0.8'
        }

        @base_url = "https://www.jiomart.com/c/groceries/dairy-bakery/61/page/"
    end

      def scrap_data
        file = "#{Rails.root}/public/jiomart.csv"
        csv_headers = ["Images"]
        (1..10).each do |page|
          if is_valid_url? base_url
            doc = HTTParty.get(base_url + "#{page}",headers: headers)
            File.open('try.html', 'w') { |file| file.write(doc.body) }
            parsed_page = Nokogiri::HTML(doc.body)
            products = parsed_page.css('a.prod-name')
            CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |writer|
              products.each do |product|
                detail_url = append_url + product.attributes['href'].value rescue nil
                if detail_url
                  image = get_detail(detail_url)
                  image[:images].flatten.compact.each do |image|
                    writer << [ image ]
                  end
                end
              end
            end
          end
        end
      end

     private

     def get_detail url
        if is_valid_url? url
          doc = HTTParty.get(url,headers: headers)
          File.open('try.html', 'w') { |file| file.write(doc.body) }
          parsed_page = Nokogiri::HTML(doc.body)
          h = Hash.new{[]}
          h[:images] = parsed_page.css("img.largeimage").map{|a| a.attributes['data-src'].value}.compact.map{|a| append_url + a}
          h
        else
          nil
        end
      end

      def is_valid_url? url
        uri = URI.parse url
        uri.kind_of? URI::HTTP
      rescue URI::InvalidURIError
        false
      end
  end
end


