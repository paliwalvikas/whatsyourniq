module BxBlockScrappers
  class PaytmService
    attr_accessor :headers, :base_urls, :append_url
    
    def initialize
       append_url = "https://paytmmall.com"
        @headers = {
          'Connection': 'keep-alive',
          'Pragma': 'no-cache',
          'Cache-Control': 'no-cache',
          'DNT': '1',
          'Upgrade-Insecure-Requests': '1',
          # You may want to change the user agent if you get blocked
          'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.80 Safari/537.36',
          'Referer': append_url,
          'Origin': append_url,
          'Access-Control-Allow-Origin': append_url,
          'Accept-Language': 'en-GB,en-US;q=0.9,en;q=0.8'
        }

        @base_urls = (1..20).map{|a| "https://paytmmall.com/fmcg-foods-glpid-101405?page=#{a}&category=101405" }
    end

      def scrap_data
        file = "#{Rails.root}/public/paytm.csv"
        csv_headers = ["Images"]
        CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |writer|
          base_urls.each do |base_url|
            if is_valid_url? base_url
              parsed_page = BxBlockScrappers::UrlService.new.http_noko(base_url, @headers)
              products = parsed_page.css('a._8vVO')
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
          parsed_page = BxBlockScrappers::UrlService.new.http_noko(url, @headers)
          h = Hash.new{[]}
          h[:images] = parsed_page.css("img").map{|a| a.attributes['src'].value}
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