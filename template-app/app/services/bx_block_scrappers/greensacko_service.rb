module BxBlockScrappers
  class GreensackoService
    attr_accessor :headers, :base_urls, :append_url
    require 'google/cloud/vision'
    require 'google/cloud/vision/v1/image_annotator'  
    ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "#{Rails.root}/lib/key.json"
    
    def initialize
       @append_url = "https://thegreensnackco.com"
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

        @base_urls = BxBlockScrappers::UrlService.new.greensacko #["https://thegreensnackco.com/collections/all","https://thegreensnackco.com/collections/nuts-seeds","https://thegreensnackco.com/collections/6-grain-stix","https://thegreensnackco.com/collections/quinoa-puffs","https://thegreensnackco.com/collections/roasted-namkeen","https://thegreensnackco.com/collections/makhana","https://thegreensnackco.com/collections/superseeds","https://thegreensnackco.com/collections/kids-snacks","https://thegreensnackco.com/collections/value-packs","https://thegreensnackco.com/collections/gifting"]
    end

      def scrap_data
        file = "#{Rails.root}/public/thegreensnackco.csv"
        csv_headers = ["Images",'Product Name','Price','Price post discount','Nutrition facts','Ingredients']
        CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |writer|
          @base_urls.each do |base_url|
            (1..5).each do |page|
              if is_valid_url? base_url
                doc = HTTParty.get("#{base_url}?page=#{page}",headers: headers)
                parsed_page = Nokogiri::HTML(doc.body)
                products = parsed_page.css('a.product-grid-image')
                products.each do |product|
                  value = {}
                  detail_url = @append_url + product.attributes['href'].value rescue nil
                  if detail_url
                    get_detail(detail_url, value)
                    writer << [value[:img], value[:p_name] , value[:mrp], value[:p_post_d], value[:nutrition], value[:ingredient] ]
                  end
                end
              end
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

    def get_detail(url,value)
      if is_valid_url? url
        doc = HTTParty.get(url,headers: headers)
        parsed_page = Nokogiri::HTML(doc.body)
        value[:img] = parsed_page.search('a.fancybox').map{ |o| o.attributes['href'].value}
        value[:img] = value[:img].map{|img| "https:#{img}"}
        value[:p_name] = parsed_page.css("h1.product-title").text.squish
        mrp = parsed_page.search('div.prices').text.squish.split(' ')
        value[:mrp] = mrp[1]
        value[:p_post_d] = mrp[3]
        for_gl = parsed_page.search('div.tab-content').search('img').map{|i| i.attributes['src'].value}
        BxBlockScrappers::UrlService.new.google_fetch_data(for_gl, value) if for_gl.present?
      else
        nil
      end
    end


  end
end


    # def google_fetch_data(image, value)
    #   image.each do |img|
    #     img.squish!
    #     image_annotator = Google::Cloud::Vision::V1::ImageAnnotator::Client.new
    #     response = image_annotator.document_text_detection image: img
    #     response.responses.each do |res|
    #       next unless res.text_annotations.present?
    #       des = res.text_annotations.first.description
    #       if des.include?('NUTRITION') || des.include?('Nutrition')
    #         value[:nutrition] = des.squish
    #       elsif des.include?('Ingredients') || des.include?('INGREDIENTS')
    #         value[:ingredient] = des.squish
    #       end
    #     end
    #   end
    # end