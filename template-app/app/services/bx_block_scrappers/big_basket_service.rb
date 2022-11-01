# module BxBlockScrappers  
#   class BigBasketService
#     attr_accessor :headers, :base_url, :append_url

#     require 'google/cloud/vision'
#     require 'google/cloud/vision/v1/image_annotator'  
#     require 'csv'

#     ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "#{Rails.root}/lib/key.json"

#     def initialize
#       @append_url = 'https://www.bigbasket.com/'
#       headers = {
#         'Connection': 'keep-alive',
#         'Pragma': 'no-cache',
#         'Cache-Control': 'no-cache',
#         'DNT': '1',
#         'Upgrade-Insecure-Requests': '1',
#         # You may want to change the user agent if you get blocked
#         'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.113 Safari/537.36',
#         'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,/;q=0.8,application/signed-exchange;v=b3;q=0.9',
#         'Origin': @append_url,
#         'Referer': @append_url,
#         'Accept-Language': 'en-GB,en-US;q=0.9,en;q=0.8'
#       }

#       @base_url = "#{@append_url}product/get-products/?slug=bakery-cakes-dairy&tab_type=[%22all%22]&sorted_on=popularity&listtype=pc"
#     end

#     def scrap_data
#       if valid_url? @base_url

#         file = "#{Rails.root}/public/basket.csv" # , 'Nutritional Information'  ,, values[0][1]
#         csv_headers = ['Image', 'Brand', 'Weight', 'Product Name', 'Price', 'Price Post Discount',
#                        'Product Description', 'Ingredient List', 'Nutritional facts', 'Nutritional Table for per 100gm/100ml/any other', 'Energy', 'Fibers', 'Proteins', 'Vitamin A', 'Vitamin C', 'Vitamin D', 'Vitamin B6', 'Vitamin B12', 'Folate', 'Calcium', 'Iron', 'Iodine', 'Calories', 'Total Fat', 'Saturated Fat', 'Monounsaturated Fat', 'Ployunsaturated Fat', 'Trans Fatty Acid', 'Cholesterol', 'Sodium', 'Sugar', 'Magnesium', 'Zinc', 'Lodine', 'Phosphorus', 'Potassium', 'Riboflavin', 'Carbohydrate', 'Fat', 'Total Sugars']
#         CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |csv|
#           (2..1000).each do |page|
#             resp = HTTParty.get("#{@base_url}&page=#{page}", headers: headers)
#             resp['tab_info']['product_map']['all']['prods'].each do |data|
#               p_data = {}
#               values = get_detail(data['sku'], p_data)
#               values_filter(values,p_data) if values[0][1].present?
#               csv << [p_data[:src], data['p_brand'], data['w'], data['pc_n'], data['mrp'], data['sp'], data['p_desc'],
#                       p_data[:ingredient], p_data[:nutrition] ,p_data[:per], p_data[:energy], p_data[:fiber], p_data[:proteins], p_data[:vitA], p_data[:vitC], p_data[:vitD], p_data[:vitB6], p_data[:vitB12], p_data[:folate], p_data[:calcium], p_data[:iron], p_data[:iodine], p_data[:calories], p_data[:total_fat], p_data[:saturated], p_data[:monounsaturated], p_data[:ployunsaturated], p_data[:trans_fa], p_data[:cholesterol], p_data[:sodium], p_data[:sugar], p_data[:magnesium], p_data[:zinc], p_data[:lodine], p_data[:phosphorus], p_data[:potassium], p_data[:riboflavin], p_data[:carbohydrate], p_data[:fat], p_data[:total_sugars]]
#             end
#           end
#         end
#       else
#         false
#       end
#     end

#     def get_detail(sku, p_data)
#       html = HTTParty.get("#{@append_url}pd/#{sku}", headers: headers)
#       parsed_page = Nokogiri::HTML(html.body)
#       i = google_fetch_data(parsed_page.css('img._3oKVV').map do |a|
#                               a.attributes['src'].value
#                             end.compact.uniq, parsed_page, p_data)
#       begin
#         [i]
#       rescue StandardError
#         []
#       end
#     end

#     private

#     def valid_url?(url)
#       uri = URI.parse url
#       uri.is_a? URI::HTTP
#     rescue URI::InvalidURIError
#       false
#     end

#     def values_filter(values, p_data)
#       (0..p_data[:nutrition].length - 1).each do |a|
#         val = p_data[:nutrition][a]
#         text = val.map{ |a| a.squish.pluralize(2).upcase if a.present? }
#         p_data[:per] = val[0]+val[1]+val[2] if is_include(text ,'PERS') 
#         p_data[:energy] = value(val) if is_include(text ,'ENERGIES') && nil_zero?(p_data[:energy])
#         p_data[:fiber] = value(val) if is_include(text ,'FIBERS') && nil_zero?(p_data[:fiber])
#         p_data[:proteins] = value(val) if is_include(text ,'PROTEINS') && nil_zero?(p_data[:proteins])
#         p_data[:vitA] = value(val) if (is_include(text ,'VITAMINS') && is_include(text ,'AS')) || is_include(text ,'VITAMIN-AS') && nil_zero?(p_data[:vitA])
#         p_data[:vitC] = value(val) if (is_include(text ,'VITAMINS') && is_include(text ,'CS')) || is_include(text ,'VITAMIN-CS') && nil_zero?(p_data[:vitC])
#         p_data[:vitD] = value(val) if (is_include(text ,'VITAMINS') && is_include(text ,'DS')) || is_include(text ,'VITAMIN-DS') && nil_zero?(p_data[:vitD])
#         p_data[:vitB6] = value(val) if (is_include(text ,'VITAMINS') && is_include(text ,'B6S')) || is_include(text ,'VITAMIN-B6S') && nil_zero?(p_data[:vitB6])
#         p_data[:vitB12] = value(val) if (is_include(text ,'VITAMINS') && is_include(text ,'B12S'))|| is_include(text ,'VITAMIN-B12S') && nil_zero?(p_data[:vitB12])
#         p_data[:folate] = value(val) if is_include(text ,'FOLATES') && nil_zero?(p_data[:folate])
#         p_data[:calcium] = value(val) if is_include(text ,'CALCIA') && nil_zero?(p_data[:calcium])
#         p_data[:iron] = value(val) if is_include(text ,'IRONS') && nil_zero?(p_data[:iron])
#         p_data[:iodine] = value(val) if is_include(text ,'IODINES') && nil_zero?(p_data[:iodine])
#         p_data[:calories] = value(val) if is_include(text ,'CALORIES') && nil_zero?(p_data[:calories])
#         p_data[:total_fat] = value(val) if is_include(text ,'TOTALS') && is_include(text ,'FATS') && nil_zero?(p_data[:total_fat])
#         p_data[:saturated] = value(val) if is_include(text ,'SATURATEDS') && nil_zero?(p_data[:saturated])
#         p_data[:monounsaturated] = value(val) if is_include(text ,'MONOUNSATURATEDS') && nil_zero?(p_data[:monounsaturated])
#         p_data[:ployunsaturated] = value(val) if is_include(text ,'PLOYUNSATURATEDS') && nil_zero?(p_data[:ployunsaturated])
#         p_data[:trans_fa] = value(val) if is_include(text ,'TRANSHES') && is_include(text ,'FATTIES') && nil_zero?(p_data[:trans_fa])
#         p_data[:sodium] = value(val) if is_include(text ,'SODIA') && nil_zero?(p_data[:sodium])
#         p_data[:sugar] = value(val) if is_include(text ,'SUGARS') && nil_zero?(p_data[:sugar])
#         p_data[:magnesium] = value(val) if is_include(text ,'MAGNESIA') && nil_zero?(p_data[:magnesium])
#         p_data[:zinc] = value(val) if is_include(text ,'ZINCS') && nil_zero?(p_data[:zinc])
#         p_data[:lodine] = value(val) if is_include(text ,'LODINES') && nil_zero?(p_data[:lodine])
#         p_data[:phosphorus] = value(val) if is_include(text ,'PHOSPHORUS') && nil_zero?(p_data[:phosphorus])
#         p_data[:potassium] = value(val) if is_include(text ,'POTASSIA') && nil_zero?(p_data[:potassium])
#         p_data[:riboflavin] = value(val) if is_include(text ,'RIBOFLAVINS') && nil_zero?(p_data[:riboflavin])
#         p_data[:carbohydrate] = value(val) if is_include(text ,'CARBOHYDRATES') && nil_zero?(p_data[:carbohydrate])
#         p_data[:fat] = value(val) if is_include(text ,'FATS') && nil_zero?(p_data[:fat])
#         p_data[:total_sugars] = value(val) if is_include(text ,'TOTALS') && is_include(text ,'SUGARS') && nil_zero?(p_data[:total_sugars])
#         p_data[:cholesterol] = value(val) if is_include(text ,'CHOLESTEROLS') && nil_zero?(p_data[:cholesterol])
#       end
#     end

#     def nil_zero?(val)
#       val.nil? || val == 0
#     end

#     def value(val)
#       text = ''
#       val.map{|i| text = i if Float(i.to_i) && i.to_i > 0}
#       text
#     end

#     def is_include(text , str)
#       text.include?(str)
#     end

#     def filter_ingradiant(parsed_page)
#       nutrition = ''
#       a = parsed_page.css('div._2fn-7').map { |a| a.children.text }
#       a.each { |p| nutrition = p if p.include? 'Nutritional Information' }
#       if nutrition.present?
#         nutrition.slice! 'Nutritional Information:' if nutrition.instance_of?(String)
#         nutrition = nutrition.split(':').split(',').flatten
#       end
#       unless nutrition.present?
#         parsed_page.css('div._26MFu').map do |i|
#           nutrition = i.children.children.text if i.children.children.text.include? 'Nutritional'
#         end
#       end
#       nutrition.present? ? nutritional_values([nutrition]) : nutrition
#     end

#     def google_fetch_data(image, parsed_page, p_data)
#       p_data[:nutrition] = []
#       p_data[:src] = []
#       p_data[:ingredient] = ''
#       image.each do |img|
#         image_annotator = Google::Cloud::Vision::V1::ImageAnnotator::Client.new
#         response = image_annotator.document_text_detection image: img
#         response.responses.each do |res|
#           next unless res.text_annotations.present?

#           des = res.text_annotations.first.description
#           if des.include?('NUTRITION') || des.include?('Nutrition')
#             p_data[:nutrition] << des
#             p_data[:src] << img
#           elsif des.include?('Ingredients') || des.include?('INGREDIENTS')
#             p_data[:ingredient] = des.squish
#             p_data[:src] << img
#           end
#         end
#       end
#       p_data[:nutrition] = p_data[:nutrition].present? ? nutritional_values(p_data[:nutrition]) : filter_ingradiant(parsed_page)
#       p_data[:src] = p_data[:src].present? ? p_data[:src] : image - [image[0]]
#       # [src.uniq, nutrition, ingredient]
#     end

#     def nutritional_values(nutrition)
#       keys = ['Per', 'Energy', 'Fiber', 'Protein', 'Vitamin A', 'Vitamin C', 'Vitamin D', 'Vitamin B6', 'Vitamin B12','Folate', 'Calcium', 'Iron', 'Iodine', 'Calories', 'Total Fat', 'Saturated', 'Monounsaturated', 'Ployunsaturated', 'Trans', 'Fatty', 'Acid', 'Cholesterol', 'Sodium', 'Sugar', 'Magnesium', 'Zinc', 'Lodine', 'Phosphorus', 'Potassium', 'Riboflavin', 'Carbohydrate', 'Fat', 'Total Sugars', 'Vitamin-A', 'Vitamin-C', 'Vitamin-D', 'Vitamin-B6', 'Vitamin-B12']
#       col = []
#       (0..nutrition.length - 1).each do |c|
#         d = nutrition[c].split.flatten.map { |i| i.capitalize }
#         (0..keys.length - 1).each do |a|
#           next unless d.index(keys[a]).present? || (keys[a].include?("Vitamin") && d.index("Vitamin").present? )
#           if keys[a].include?("Vitamin")
#             aa = keys[a].split
#             next unless d.include?(aa[1]) 
#             ing = d.slice(d.index(aa[0]))
#             ind = aa[1] == "A" ? d.index(aa[0])+1 :  d.index(aa[1])
#             val = d.slice(ind)
#             val1 = d.slice(ind + 2)
#             # val2 = d.slice(ind + 3)
#           else
#             ing = d.slice(d.index(keys[a]))
#             val = d.slice(d.index(keys[a]) + 1)
#             val1 = d.slice(d.index(keys[a]) + 2)
#             # val2 = d.slice(d.index(keys[a]) + 3)
#           end
#           col << [ing, val, val1]
#         end
#       end
#       col
#     end
#   end
# end

