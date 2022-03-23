class SnackibleService
  attr_accessor :headers, :base_urls, :append_url
  
  def initialize
     @append_url = "https://www.snackible.com"
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

      @base_urls = ["https://www.snackible.com/collections/shop-all"]
  end

    def scrap_data
      file = "#{Rails.root}/public/snackible.csv"
      csv_headers = ["Images"]
      CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |writer|
        base_urls.each do |base_url|
          if is_valid_url? base_url
            html = HTTParty.get(base_url,headers: headers)
            File.open('try.html', 'w') { |file| file.write(html) }
            parsed_page = Nokogiri::HTML(html)
            products = parsed_page.css('a.product-link')
            products.each do |product|
              detail_url = append_url + product.attributes['href'].value rescue nil
              if detail_url
                image = get_detail(detail_url)
                image[:images].flatten.compact.each do |image|
                  writer << [ "https:" + image ]
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