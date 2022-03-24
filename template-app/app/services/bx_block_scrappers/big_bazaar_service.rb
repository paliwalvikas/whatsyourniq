module BxBlockScrappers
  class BigBazaarService
    attr_accessor :headers, :base_url, :append_url, :base_image, :categories
    
    def initialize
       @append_url = "https://shop.bigbazaar.com/"
       @base_image = "https://cflare.shop.bigbazaar.com/cdn-cgi/image/width=450/"
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

        @categories = [287, 293, 283]

        @base_url = "https://express.shop.bigbazaar.com/express/product/search/lite"
    end

      def scrap_data
        file = "#{Rails.root}/public/big_bazaar.csv"
        csv_headers = ["Images"]
        CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |writer|
          categories.each do |category_id|
            details = []
            (1..20).each do |page|
              body = {"pageNo": page,"perPage": 16,"storeCode": "5538","filters": [{"name": "category","values": ["#{category_id}"]}],"searchTerm": "","searchId": "#{category_id}"}
              if is_valid_url? base_url
                @result = HTTParty.post(base_url, 
                  body: body,
                  headers: headers )
                details << @result["responseData"]["results"].map{ |a| a["simples"].map {| b| b["images"] } }.flatten.compact
              end
            end 
            details.flatten.each do |image|
              writer << [ base_image + image ]
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