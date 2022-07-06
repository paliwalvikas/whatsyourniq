module BxBlockScrappers  
  class JiomartService
    attr_accessor :headers, :base_url, :append_url
    
    def initialize
      @append_url = "https://www.jiomart.com/"
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

      
      @base_url = BxBlockScrappers::UrlService.new.jiomart
    end

    def scrap_data
      file = "#{Rails.root}/public/jiomart.csv"
      csv_headers = ['Images', 'Product Name', 'Brand', 'Weight', 'Price', 'Post Price Discount']
      CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |writer|
        @base_url.each do |base_url|
          (1..10).each do |page| 
            if is_valid_url? base_url
              link =  base_url.include?("page") ? base_url+"#{page}" : base_url+"/page/#{page}"
              parsed_page = http_party_nokogiri(link)
              products = parsed_page.search('a.prod-name')
              products.each do |product|
                value = {}
                detail_url = @append_url + product.attributes['href'].value rescue nil
                if detail_url
                  image = get_detail(detail_url, value)
                  writer << [ value[:img], value[:p_name],value[:brand], value[:weight] ]
                end
              end
            end
          end
        end
      end
    end

     private

    def get_detail(url, value)
      if is_valid_url? url
        parsed_page = http_party_nokogiri(url)
        parsed_page.search('table.prodDetTable').each do |i|
          text = i.text.squish
          value[:brand] =  text.split.slice(text.index('Brand')+1) if i.text.include?('Brand') 
          value[:weight] =  text if i.text.include?('Net Quantity') 
        end
        value[:p_name] = parsed_page.search('div.title-section').text
        value[:img] = parsed_page.css("img.largeimage").map{|a| a.attributes['data-src'].value}
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

    def http_party_nokogiri(link)
      doc = HTTParty.get(link ,headers: headers)
      parsed_page = Nokogiri::HTML(doc.body)
    end

  end
end



                # image[:images].flatten.compact.each do |image|
                # end