module BxBlockScrappers
  class BigBasketService
    attr_accessor :headers, :base_url, :append_url
    
    def initialize
      @append_url = "https://www.bigbasket.com/"
      @headers = {
          'Connection': 'keep-alive',
          'Pragma': 'no-cache',
          'Cache-Control': 'no-cache',
          'DNT': '1',
          'Upgrade-Insecure-Requests': '1',
          # You may want to change the user agent if you get blocked
          'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.113 Safari/537.36',
          'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,/;q=0.8,application/signed-exchange;v=b3;q=0.9',
          'Origin': @append_url,
          'Referer': @append_url,
          'Accept-Language': 'en-GB,en-US;q=0.9,en;q=0.8',
      }

      @base_url = "#{@append_url}product/get-products/?slug=bakery-cakes-dairy&tab_type=[%22all%22]&sorted_on=popularity&listtype=pc"
    end

    def scrap_data
      if is_valid_url? base_url
        images = []
        (2..100).each do |page|
          resp = HTTParty.get(base_url + "&page=#{page}",headers: headers)
          skus = resp["tab_info"]["product_map"]["all"]["prods"].each do |a|
            images << get_detail(a['sku'])
          end
        end
        images.flatten.compact rescue []
      else
        return false
      end
    end

    def get_detail sku
      html = HTTParty.get("#{append_url}pd/#{sku}",headers: headers)
      parsed_page = Nokogiri::HTML(html.body)
      parsed_page.css("img._3oKVV").map{|a| a.attributes['src'].value}.compact rescue []
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