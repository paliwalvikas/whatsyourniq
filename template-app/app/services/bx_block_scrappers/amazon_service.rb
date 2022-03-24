module BxBlockScrappers
  class AmazonService
    attr_accessor :headers, :base_url, :append_url
    
    def initialize
      @append_url = "https://www.amazon.in/"
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

      @base_url = "https://www.amazon.in/Gourmet-Specialty-Foods/b/?ie=UTF8&node=2454178031&ref_=nav_cs_grocery"
    end

    def scrap_data
      if is_valid_url? base_url
        details = []
        html = HTTParty.get(base_url,headers: headers)
        parsed_page = Nokogiri::HTML(html)
        products = parsed_page.css('a.acs-product-block__product-title')
        products.each do |product|
          detail_url = append_url + product.attributes['href'].value rescue nil
          if detail_url
            details << get_detail(detail_url)
          end
        end
        return details
      else
        return false
      end
    end

    def get_detail url
      if is_valid_url? url
        html = HTTParty.get(url,headers: headers)
        parsed_page = Nokogiri::HTML(html)
        h = Hash.new{[]}
        h[:images] = parsed_page.css("img.a-dynamic-image").map{|a| a.attributes['src'].value}.compact
        h
      else
        nil
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