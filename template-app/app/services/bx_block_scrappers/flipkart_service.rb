module BxBlockScrappers
  require 'nokogiri'
  require 'pp'
  class FlipkartService
    attr_accessor :headers, :base_urls, :append_url
    
    def initialize
       @append_url = "https://www.flipkart.com/"
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

        @base_urls = ["https://www.flipkart.com/grocery/snacks-beverages/biscuits/pr?sid=73z,ujs,eb9&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_3e7e07ef-4c03-40c3-b2ef-21912a097a7a_2_HLMQWU0YZHXB_MC.0B0O6N61TOZP&otracker=clp_rich_navigation_1_2.navigationCard.RICH_NAVIGATION_Snacks%2B%2526%2BBeverages~Biscuits_grocery-supermart-store_0B0O6N61TOZP&otracker1=clp_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_1_L1_view-all&cid=0B0O6N61TOZP", "https://www.flipkart.com/grocery/staples/dals-pulses/pr?sid=73z,bpe,3uv&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_88632bbc-f9cc-4a9c-bf3e-77c464be38d7_2_HLMQWU0YZHXB_MC.3NLX7GJTOA3R&otracker=dynamic_rich_navigation_1_2.navigationCard.RICH_NAVIGATION_Staples~Dals%2B%2526%2BPulses_3NLX7GJTOA3R&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_1_L1_view-all&cid=3NLX7GJTOA3R", "https://www.flipkart.com/grocery/staples/ghee-oils/pr?sid=73z,bpe,4wu&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_efb6517f-f07e-49ec-832d-7aa009699cf4_2_CWIMLPR7MMX6_MC.QW9A7WPEBLP6&otracker=dynamic_rich_navigation_2_2.navigationCard.RICH_NAVIGATION_Staples~Ghee%2B%2526%2BOils_QW9A7WPEBLP6&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_2_L1_view-all&cid=QW9A7WPEBLP6", "https://www.flipkart.com/grocery/staples/atta-flours/pr?sid=73z,bpe,9da&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_ad93fd7d-555a-45fc-90da-7d16fd3bf421_2_CWIMLPR7MMX6_MC.ZWBFCX62G9LP&otracker=dynamic_rich_navigation_3_2.navigationCard.RICH_NAVIGATION_Staples~Atta%2B%2526%2BFlours_ZWBFCX62G9LP&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_3_L1_view-all&cid=ZWBFCX62G9LP", "https://www.flipkart.com/grocery/staples/masalas-spices/pr?sid=73z,bpe,a6m&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_46fc4edf-a7f1-4e6f-9dd5-baf69b878bb6_2_CWIMLPR7MMX6_MC.QFQ3Q4E8ZB2I&otracker=dynamic_rich_navigation_4_2.navigationCard.RICH_NAVIGATION_Staples~Masalas%2B%2526%2BSpices_QFQ3Q4E8ZB2I&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_4_L1_view-all&cid=QFQ3Q4E8ZB2I", "https://www.flipkart.com/grocery/staples/rice-rice-products/pr?sid=73z,bpe,zwp&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_4e5ae972-7725-4070-a047-902eff0c3ff7_2_CWIMLPR7MMX6_MC.GQEJYG9UMBCO&otracker=dynamic_rich_navigation_5_2.navigationCard.RICH_NAVIGATION_Staples~Rice%2B%2526%2BRice%2BProducts_GQEJYG9UMBCO&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_5_L1_view-all&cid=GQEJYG9UMBCO", "https://www.flipkart.com/grocery/staples/dry-fruits-nuts-seeds/pr?sid=73z,bpe,dtp&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_afc7c172-9826-4488-aba6-fd68dba3f01c_2_CWIMLPR7MMX6_MC.X697907L5MB0&otracker=dynamic_rich_navigation_6_2.navigationCard.RICH_NAVIGATION_Staples~Dry%2BFruits%252C%2BNuts%2B%2526%2BSeeds_X697907L5MB0&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_6_L1_view-all&cid=X697907L5MB0", "https://www.flipkart.com/grocery/staples/sugar-jaggery-salt/pr?sid=73z,bpe,fdl&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_9944b1c1-13bc-4e12-9b02-a068406d9a2b_2_CWIMLPR7MMX6_MC.XI6TQHBVLUGF&otracker=dynamic_rich_navigation_7_2.navigationCard.RICH_NAVIGATION_Staples~Sugar%252C%2BJaggery%2B%2526%2BSalt_XI6TQHBVLUGF&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_7_L1_view-all&cid=XI6TQHBVLUGF", "https://www.flipkart.com/grocery/snacks-beverages/biscuits/pr?sid=73z,ujs,eb9&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_afa6fd76-a24f-4be2-b777-57f5294b3931_2_CWIMLPR7MMX6_MC.AZ9TH6KGXIQX&otracker=dynamic_rich_navigation_1_2.navigationCard.RICH_NAVIGATION_Snacks%2B%2526%2BBeverages~Biscuits_AZ9TH6KGXIQX&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_1_L1_view-all&cid=AZ9TH6KGXIQX", "https://www.flipkart.com/grocery/snacks-beverages/chipsnamkeen-snacks/pr?sid=73z,ujs,dd9&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_3a8e2640-eeed-4723-90b8-32d3985008ad_2_CWIMLPR7MMX6_MC.ZTW4LDXW99L4&otracker=dynamic_rich_navigation_2_2.navigationCard.RICH_NAVIGATION_Snacks%2B%2526%2BBeverages~Chips%252CNamkeen%2B%2526%2BSnacks_ZTW4LDXW99L4&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_2_L1_view-all&cid=ZTW4LDXW99L4", "https://www.flipkart.com/grocery/snacks-beverages/tea/pr?sid=73z,ujs,amr&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_8978d86a-2892-4580-865f-55de43dd06ea_2_CWIMLPR7MMX6_MC.WGRAZWGDPE1W&otracker=dynamic_rich_navigation_3_2.navigationCard.RICH_NAVIGATION_Snacks%2B%2526%2BBeverages~Tea_WGRAZWGDPE1W&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_3_L1_view-all&cid=WGRAZWGDPE1W", "https://www.flipkart.com/grocery/snacks-beverages/coffee/pr?sid=73z,ujs,t7k&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_46dd8e7c-ffe2-4454-996d-0456f58dcf5a_2_CWIMLPR7MMX6_MC.098FWDWWR6ZV&otracker=dynamic_rich_navigation_4_2.navigationCard.RICH_NAVIGATION_Snacks%2B%2526%2BBeverages~Coffee_098FWDWWR6ZV&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_4_L1_view-all&cid=098FWDWWR6ZV", "https://www.flipkart.com/grocery/snacks-beverages/juices/pr?sid=73z,ujs,afd&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_d98d6978-a367-457e-b6a3-270826f5c8d5_2_CWIMLPR7MMX6_MC.W5PUVK1VCI95&otracker=dynamic_rich_navigation_5_2.navigationCard.RICH_NAVIGATION_Snacks%2B%2526%2BBeverages~Juices_W5PUVK1VCI95&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_5_L1_view-all&cid=W5PUVK1VCI95", "https://www.flipkart.com/grocery/snacks-beverages/health-drink-mix/pr?sid=73z,ujs,vnq&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_1d75d524-2abc-42dc-bfa9-dac8f7cdbcde_2_CWIMLPR7MMX6_MC.0UDCKV2OVSBR&otracker=dynamic_rich_navigation_6_2.navigationCard.RICH_NAVIGATION_Snacks%2B%2526%2BBeverages~Health%2BDrink%2BMix_0UDCKV2OVSBR&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_6_L1_view-all&cid=0UDCKV2OVSBR", "https://www.flipkart.com/grocery/snacks-beverages/soft-drinks/pr?sid=73z,ujs,dfw&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_6cfc0778-6c9e-4111-9ece-7cfa80e4b1a2_2_CWIMLPR7MMX6_MC.L6I5OTOPKRJ0&otracker=dynamic_rich_navigation_7_2.navigationCard.RICH_NAVIGATION_Snacks%2B%2526%2BBeverages~Soft%2BDrinks_L6I5OTOPKRJ0&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_7_L1_view-all&cid=L6I5OTOPKRJ0", "https://www.flipkart.com/grocery/snacks-beverages/soft-drinks/pr?sid=73z,ujs,dfw&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_8b499f88-f0cf-4739-b931-b5c4f1275e55_2_CWIMLPR7MMX6_MC.L6I5OTOPKRJ0&otracker=dynamic_rich_navigation_7_2.navigationCard.RICH_NAVIGATION_Snacks%2B%2526%2BBeverages~Soft%2BDrinks_L6I5OTOPKRJ0&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_7_L1_view-all&cid=L6I5OTOPKRJ0", "https://www.flipkart.com/grocery/snacks-beverages/squash-syrups/pr?sid=73z,ujs,iau&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_aafbf2be-57f4-4432-90bb-1a2f1e66bb7e_2_CWIMLPR7MMX6_MC.X92O1TC1W20T&otracker=dynamic_rich_navigation_8_2.navigationCard.RICH_NAVIGATION_Snacks%2B%2526%2BBeverages~Instant%2BDrink%2BMixes%252C%2BSquash%2B%2526%2BSyrups_X92O1TC1W20T&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_8_L1_view-all&cid=X92O1TC1W20T", "https://www.flipkart.com/grocery/packaged-food/breakfast-cereals/pr?sid=73z,u0u,bx9&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_0ae32074-cab0-48e9-aede-3b235771c14e_2_CWIMLPR7MMX6_MC.NXLSWOZVU3Q0&otracker=dynamic_rich_navigation_1_2.navigationCard.RICH_NAVIGATION_Packaged%2BFood~Breakfast%2BCereals_NXLSWOZVU3Q0&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_1_L1_view-all&cid=NXLSWOZVU3Q0", "https://www.flipkart.com/grocery/packaged-food/noodles-pasta/pr?sid=73z,u0u,ltz&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_ac091450-d1be-42a4-aa92-5f6f768d7a6d_2_CWIMLPR7MMX6_MC.GOSA97N625VX&otracker=dynamic_rich_navigation_2_2.navigationCard.RICH_NAVIGATION_Packaged%2BFood~Noodles%2B%2526%2BPasta_GOSA97N625VX&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_2_L1_view-all&cid=GOSA97N625VX", "https://www.flipkart.com/grocery/packaged-food/ketchups-spreads/pr?sid=73z,u0u,0tl&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_5b05d076-5951-4a5b-952b-a9dd053dfa44_2_CWIMLPR7MMX6_MC.Y2HU0NO6WEWM&otracker=dynamic_rich_navigation_3_2.navigationCard.RICH_NAVIGATION_Packaged%2BFood~Ketchups%2B%2526%2BSpreads_Y2HU0NO6WEWM&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_3_L1_view-all&cid=Y2HU0NO6WEWM", "https://www.flipkart.com/grocery/packaged-food/chocolates-sweets/pr?sid=73z,u0u,7o6&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_fadb0c37-4b78-4082-b6d0-84755cc9b4c5_2_CWIMLPR7MMX6_MC.XDTF6QJ4BWBW&otracker=dynamic_rich_navigation_4_2.navigationCard.RICH_NAVIGATION_Packaged%2BFood~Chocolates%2B%2526%2BSweets_XDTF6QJ4BWBW&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_4_L1_view-all&cid=XDTF6QJ4BWBW", "https://www.flipkart.com/grocery/packaged-food/jams-honey/pr?sid=73z,u0u,j4e&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_02e02bf1-8d86-4df7-a34f-7cb75602fc31_2_CWIMLPR7MMX6_MC.NOMWVMJOO0PM&otracker=dynamic_rich_navigation_5_2.navigationCard.RICH_NAVIGATION_Packaged%2BFood~Jams%2B%2526%2BHoney_NOMWVMJOO0PM&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_5_L1_view-all&cid=NOMWVMJOO0PM", "https://www.flipkart.com/grocery/packaged-food/pickles-chutney/pr?sid=73z,u0u,03x&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_a48737fd-11b5-49ec-af5e-d0db85997607_2_CWIMLPR7MMX6_MC.SYSHNZJX28YU&otracker=dynamic_rich_navigation_6_2.navigationCard.RICH_NAVIGATION_Packaged%2BFood~Pickles%2B%2526%2BChutney_SYSHNZJX28YU&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_6_L1_view-all&cid=SYSHNZJX28YU", "https://www.flipkart.com/grocery/packaged-food/pickles-chutney/pr?sid=73z,u0u,03x&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_af621770-ccc0-4d98-9e5a-5ca3d75ca3b9_2_CWIMLPR7MMX6_MC.SYSHNZJX28YU&otracker=dynamic_rich_navigation_6_2.navigationCard.RICH_NAVIGATION_Packaged%2BFood~Pickles%2B%2526%2BChutney_SYSHNZJX28YU&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_6_L1_view-all&cid=SYSHNZJX28YU", "https://www.flipkart.com/grocery/packaged-food/ready-to-cook/pr?sid=73z,u0u,0gv&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_79b382da-6812-4d1e-a010-1c0d20b3bfec_2_CWIMLPR7MMX6_MC.N8BWXHWL92JS&otracker=dynamic_rich_navigation_7_2.navigationCard.RICH_NAVIGATION_Packaged%2BFood~Ready%2BTo%2BCook_N8BWXHWL92JS&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_7_L1_view-all&cid=N8BWXHWL92JS", "https://www.flipkart.com/grocery/packaged-food/cooking-sauces-vinegar/pr?sid=73z,u0u,wd7&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_edf2e164-dbfd-41cd-b85c-259b4a38b8af_2_HLMQWU0YZHXB_MC.EFWTG39Y3RYE&otracker=dynamic_rich_navigation_8_2.navigationCard.RICH_NAVIGATION_Packaged%2BFood~Cooking%2BSauces%2B%2526%2BVinegar_EFWTG39Y3RYE&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_8_L1_view-all&cid=EFWTG39Y3RYE", "https://www.flipkart.com/grocery/packaged-food/baking/pr?sid=73z,u0u,td1&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_fbe56513-2886-42ac-b207-53d594ef1cae_2_HLMQWU0YZHXB_MC.9RXSKIHYLXEP&otracker=dynamic_rich_navigation_9_2.navigationCard.RICH_NAVIGATION_Packaged%2BFood~Baking_9RXSKIHYLXEP&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_9_L1_view-all&cid=9RXSKIHYLXEP", "https://www.flipkart.com/grocery/dairy-eggs/dairy/pr?sid=73z,esa,dt6&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_d0540a60-0bb4-48a3-849f-b5f50629c521_2_HLMQWU0YZHXB_MC.OQD5KWRKDHY5&otracker=dynamic_rich_navigation_1_2.navigationCard.RICH_NAVIGATION_Dairy%2B%2526%2BEggs~Dairy_OQD5KWRKDHY5&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_1_L1_view-all&cid=OQD5KWRKDHY5", "https://www.flipkart.com/grocery/dairy-eggs/eggs/pr?sid=73z,esa,hh7&otracker=categorytree&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_02d3aeab-d24f-4bb6-a79c-b76469e44320_2_HLMQWU0YZHXB_MC.5JB6HYB4JHI5&otracker=dynamic_rich_navigation_2_2.navigationCard.RICH_NAVIGATION_Dairy%2B%2526%2BEggs~Eggs_5JB6HYB4JHI5&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_2_L1_view-all&cid=5JB6HYB4JHI5", "https://www.flipkart.com/grocery/snacks-beverages/water/pr?sid=73z%2Cujs%2Cwsx&otracker[]=categorytree&otracker[]=pp_rich_navigation_1_1.navigationCard.RICH_NAVIGATION_Snacks%2B%2526%2BBeverages%2B~Biscuits%2B_5LHB0T8V92K2&marketplace=GROCERY&fm=neo%2Fmerchandising&iid=M_4b979434-a3a9-4fa7-bd2c-2dd2136ba11f_1_TD249NVPLJWU_MC.5LHB0T8V92K2&cid=5LHB0T8V92K2&fm=neo%2Fmerchandising&iid=M_83f4ea5c-78ea-4efb-b53a-4a45be92c14d_2_CWIMLPR7MMX6_MC.4A84BX21Y0S3&otracker=dynamic_rich_navigation_9_2.navigationCard.RICH_NAVIGATION_Snacks%2B%2526%2BBeverages~Water_4A84BX21Y0S3&otracker1=dynamic_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_9_L1_view-all&cid=4A84BX21Y0S3"]
    end

      def scrap_data
        file = "#{Rails.root}/public/flipkart.csv"
        csv_headers = ["Images"]
        CSV.open(file, 'w', write_headers: true, headers: csv_headers) do |writer|
          base_urls.each do |base_url|
            details = []
            if is_valid_url? base_url
              html = HTTParty.get(base_url,headers: headers)
              deep_link = Nokogiri::HTML(html.body).search('div._1vhGDP')
              deep_link.each do |children|
                children.children.each do |value|
                  obj_id = value.values.last
                  deep_html = HTTParty.get(base_url+obj_id,headers: headers)
                  link = Nokogiri::HTML(deep_html.body).search('img._396cs4')
                  link.each do |images_url|
                    details << images_url.attributes["src"].value
                  end
                end
              end
            end
            details.each do |image|
              writer << [ image ]
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
  end
end