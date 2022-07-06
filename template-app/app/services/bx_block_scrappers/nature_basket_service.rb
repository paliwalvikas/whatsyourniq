module BxBlockScrappers 
  class NatureBasketService
    attr_accessor :headers, :base_urls, :append_url
    
    def initialize
      @append_url = "https://www.naturesbasket.co.in"
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

      @base_url = ["https://www.naturesbasket.co.in/Online-grocery-shopping/International-Cuisine/4_0_0"]
    end

    def scrap_data
      file = "#{Rails.root}/public/naturesbasket.csv"
      csv_headers = ["Images"]
      CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |writer|
        # base_urls.each do |base_url|
          if is_valid_url? @base_url[0]
            deep_urls = []
            parsed_page = BxBlockScrappers::UrlService.new.http_noko(@base_url[0])
            parsed_page.search('div.divSuperCategoryTitle').each do |i|
              i.children.map{|o| deep_urls << o.attributes['href'].value if o.attributes['href'].present?}
            end
            deep_urls.each do |link|
              parsed_page = BxBlockScrappers::UrlService.new.http_noko(@append_url+link)
              # products = parsed_page.css('a.linkdisabled')
              products.each do |product|
                detail_url = @append_url + product.attributes['href'].value rescue nil
                if detail_url
                  image = get_detail(detail_url)
                  image[:images].flatten.compact.each do |image|
                    writer << [ image ]
                  end
                end
              end
            end
          end
        # end
      end
    end

    private

    def get_detail url
      if is_valid_url? url
        html = HTTParty.get(url,headers: headers)
        File.open('try.html', 'w') { |file| file.write(html) }
        parsed_page = Nokogiri::HTML(html)
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
# ,"https://www.naturesbasket.co.in/Online-grocery-shopping/InternationalCuisine/Italian-Continental/Pasta/67_0_0","https://www.naturesbasket.co.in/Online-grocery-shopping/InternationalCuisine/Italian-Continental/WholeWheat-OtherPastas/68_0_0","https://www.naturesbasket.co.in/Online-grocery-shopping/InternationalCuisine/Italian-Continental/ArborioRice-Polenta/69_0_0","https://www.naturesbasket.co.in/Online-grocery-shopping/InternationalCuisine/Italian-Continental/Sauces,Pastes-Marinades/70_0_0","https://www.naturesbasket.co.in/Online-grocery-shopping/InternationalCuisine/Italian-Continental/Olives,Capers-Tapenades/71_0_0"]