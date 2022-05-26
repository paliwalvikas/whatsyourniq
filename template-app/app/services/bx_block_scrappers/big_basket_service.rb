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
        # file = "/home/rails/Documents/scrapping 2/scrapping/basket.csv"
        file = "#{Rails.root}/public/basket.csv"
        csv_headers = ["Image", "Brand", "Weight", "Product Name", "Price","Nutritional Information", "Ingredient List"]
        CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |csv|
          # images = []
          (2..100).each do |page|
            resp = HTTParty.get(base_url + "&page=#{page}",headers: headers)
            skus = resp["tab_info"]["product_map"]["all"]["prods"].each do |a|
              values = get_detail(a['sku'])
              csv << [values[0]-["https://www.bbassets.com/monsters-inc/static/be1f00c92cf43c5b36397fe28c88a793.svg"],a['p_brand'], a['w'], a['pc_n'], a['mrp'], values[1].strip()]
            end
          end
          # images.flatten.compact rescue []
        end
      else
        return false
      end
    end

    def get_detail sku
      html = HTTParty.get("#{append_url}pd/#{sku}",headers: headers)
      parsed_page = Nokogiri::HTML(html.body)
      i = filter_ingradiant(parsed_page)
      return [parsed_page.css("img._3oKVV").map{|a| a.attributes['src'].value}.compact, i] rescue []
    end
    
    private

    def is_valid_url? url
      uri = URI.parse url
      uri.kind_of? URI::HTTP
    rescue URI::InvalidURIError
      false
    end

    def filter_ingradiant(parsed_page)
      a = parsed_page.css("div._2fn-7").map{|a| a.children.text}
      a.each{|p|  @x = p if p.include? "Nutritional Information"}
      @x
      # @x.split(',')
      # xxx = xx.split(',').first.strip()
      # xxx.slice! "Nutritional Information:"
      # xxx
    end
  end
end


