module BxBlockScrappers  
  class HealthkartService
    attr_accessor :headers, :base_urls, :append_url
    
    def initialize
       @append_url = "https://www.healthkart.com"
        headers = {
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

        @base_urls = ["https://www.healthkart.com/health-food-n-drinks?navKey=CP-hfd-n-drnks&itracker=w:category|product|1|;p:4|;c:health-food-n-drinks|;", "https://www.healthkart.com/sports-nutrition?navKey=CP-nt-sn&itracker=w:category|product|1|;p:1|;c:sports-nutrition|;"]
    end

      def scrap_data
        file = "#{Rails.root}/public/healthkart.csv"
        csv_headers = ['Images', 'Product Name', 'Weight','product Price', 'Post Price Discount']
        CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |writer|
          base_urls.each do |base_url|
            if is_valid_url? base_url
              deep_url = []
              html = HTTParty.get(base_url,headers: headers)
              parsed_page = Nokogiri::HTML(html.body)
              parsed_page.search('div.toggle-box').search('a').map{|i| deep_url << i.attributes['href'].value if i.attributes['href'].present? }
              deep_url.each do |link|
                html = HTTParty.get((@append_url + link ), headers: headers)
                products = Nokogiri::HTML(html.body).search('a.variantBoxDesktopLayoutLoyal_variant-img-container__1ZE7P')
                products.each do |product|
                  value = {}
                  detail_url = append_url + product.attributes['href'].value rescue nil 
                  get_detail(detail_url, value)
                  writer << [value[:img] , value[:p_name], value[:weight] , value[:price][1], value[:price][0] ]
                end 
              end
            end
          end
        end
      end

     private

     def get_detail(url, value)
        if is_valid_url? url
          value[:img] = []
          html = HTTParty.get(url,headers: headers)
          parsed_page = Nokogiri::HTML(html.body)
          parsed_page.search('img.play-btn').map{|i| value[:img] << i.attributes['src'].value}
          value[:p_name] = parsed_page.search('h1.variant-name').text.squish
          value[:price] = parsed_page.search('div.price').map{|i| i.text}
          value[:p_brand] = parsed_page.search('div.brand-interlink').text
          parsed_page.search('a.attribute-item').map{|i| value[:weight] = i.text}
          value[:weight].slice!("#{value[:price][0]}") if value[:weight].present? && value[:weight].include?("#{value[:price][0]}")
          google_lens(value) if value[:img].present?
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

      def google_lens(value)
        BxBlockScrappers::UrlService.new.google_fetch_data(value[image], value)
      end
  end
end