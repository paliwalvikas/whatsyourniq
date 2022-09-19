module BxBlockCatalogue
  class VitaminValueService 

    def set_vitamin_value_for_solid(ingredient, value)
      case ingredient
      when "vit_a"
        if value < 150
          return 0.5
        elsif value > 150 && value < 300
          return 0.6
        elsif value > 300 
          return 1
        end
      when "vit_c"
        if value < 12
          return 0.5
        elsif value > 12 && value < 24
          return 0.6
        elsif value > 24
          return 1
        end
      when "vit_d"
        if value < 2.25
          return 0.5
        elsif value > 2.25 &&  value < 4.5
          return 0.6
        elsif value > 4.5
          return 1
        end
      when "vit_b6"
        if value < 0.285
          return 0.5
        elsif value > 0.285 && value < 0.57
          return 0.6
        elsif value > 0.57
          return 1
        end 
      when "vit_b12"
        if value < 0.375
          return 0.5
        elsif value > 0.375 && value < 0.75
          return 0.6
        elsif value > 0.75
          return 1
        end   
      when "vit_b9"
        if value < 45
          return 0.5
        elsif value > 45 && value < 90
          return 0.6
        elsif value > 90
          return 1
        end     
      when "vit_b2"
        if value < 0.3
          return 0.5
        elsif value > 0.3 && value < 0.6
          return 0.6
        elsif value > 0.6
          return 1
        end
      when "vit_b3"
        if value < 2.1
          return 0.5
        elsif value > 2.1 && value < 4.3
          return 0.6
        elsif value > 4.3
          return 1
        end       
      when "vit_b1"
        if value < 2.163
          return 0.5
        elsif value > 2.163 && value < 4.326
          return 0.6
        elsif value > 4.326
          return 1
        end       
      when "vit_b5"
        if value < 0.75
          return 0.5
        elsif value > 0.75 && value < 1.5
          return 0.6
        elsif value > 1.5
          return 1
        end 
      when "vit_b7"
        if value < 6
          return 0.5
        elsif value > 6 && value < 12
          return 0.6
        elsif value > 12
          return 1
        end 
      when "calcium"
        if value < 150
          return 0.5
        elsif value > 150 && value < 300
          return 0.6
        elsif value > 300
          return 1
        end   
      when "iron"
        if value < 2.85
          return 0.5
        elsif value > 2.85 && value < 5.7
          return 0.6
        elsif value > 5.7
          return 1
        end
      when "magnesium"
        if value < 58
          return 0.5
        elsif value > 58 &&  value < 115
          return 0.6
        elsif value > 115
          return 1
        end
      when "zinc"
        if value < 2.25
          return 0.5
        elsif value > 2.25 && value < 5.1
          return 0.6
        elsif value > 5.1
          return 1
        end     
      when "iodine"
        if value < 2.22
          return 0.5
        elsif value > 2.22 && value < 45
          return 0.6
        elsif value > 45
          return 1
        end 
      when "potassium"
        if value < 525
          return 0.5
        elsif value > 525 && value < 1050
          return 0.6
        elsif value > 1050
          return 1
        end   
      when "phosphorus"
        if value < 150
          return 0.5
        elsif value > 150 &&  value < 300
          return 0.6
        elsif value > 300
          return 1
        end 
      when "manganese"
        if value < 0.6
          return 0.5
        elsif value > 0.6 &&  value < 1.2
          return 0.6
        elsif value > 1.2
          return 1
        end 
      when "copper"
        if value < 0.25
          return 0.5
        elsif value > 0.25 &&  value < 0.5
          return 0.6
        elsif value > 0.5
          return 1
        end     
      when "selenium"
        if value < 6
          return 0.5
        elsif value > 6 &&  value < 12
          return 0.6
        elsif value > 12
          return 1
        end   
      when "chloride"
        if value < 442
          return 0.5
        elsif value > 442 && value < 885
          return 0.6
        elsif value > 885
          return 1
        end 
      when "chromium"
        if value < 7.5
          return value
        elsif value > 7.5 &&  value < 15
          return 0.6
        elsif value > 15
          return 1
        end   
      end                                       
    end 

    def set_vitamin_value_for_beaverage(ingredient, value)
      case ingredient
      when "vit_a"
        if value < 75
          return 0.5
        elsif value > 75 && value < 150
          return 0.6
        elsif value > 150 
          return 1
        end
      when "vit_c"
        if value < 6
          return 0.5
        elsif value > 6 && value < 12
          return 0.6
        elsif value > 12
          return 1
        end
      when "vit_d"
        if value < 1.12
          return 0.5
        elsif value > 1.12 &&  value < 2.25
          return 0.6
        elsif value > 2.25
          return 1
        end
      when "vit_b6"
        if value < 0.14
          return 0.5
        elsif value > 0.14 && value < 0.285
          return 0.6
        elsif value > 0.285
          return 1
        end 
      when "vit_b12"
        if value < 0.19
          return 0.5
        elsif value > 0.19 && value < 0.375
          return 0.6
        elsif value > 0.375
          return 1
        end   
      when "vit_b9"
        if value < 22.5
          return 0.5
        elsif value > 22.5 && value < 45
          return 0.6
        elsif value > 45
          return 1
        end     
      when "vit_b2"
        if value < 0.15
          return 0.1
        elsif value > 0.15 && value < 0.3
          return 0.6
        elsif value > 0.3
          return 1
        end
      when "vit_b3"
        if value < 1.05
          return 0.1
        elsif value > 1.05 && value < 2.1
          return 0.6
        elsif value > 2.1
          return 1
        end       
      when "vit_b1"
        if value < 1.08
          return 0.1
        elsif value > 1.08 && value < 2.16
          return 0.6
        elsif value > 4.326
          return 1
        end       
      when "vit_b5"
        if value < 0.375
          return 0.1
        elsif value > 0.375 && value < 0.75
          return 0.6
        elsif value > 0.75
          return 1
        end 
      when "vit_b7"
        if value < 3
          return 0.1
        elsif value > 3 && value < 6
          return 0.6
        elsif value > 6
          return 1
        end 
      when "calcium"
        if value < 75
          return 0.1
        elsif value > 75 && value < 150
          return 0.6
        elsif value > 150
          return 1
        end   
      when "iron"
        if value < 1.425
          return 0.1
        elsif value > 1.425 && value < 2.85
          return 0.6
        elsif value > 2.85
          return 1
        end
      when "magnesium"
        if value < 29
          return 0.1
        elsif value > 29 &&  value < 58
          return 0.6
        elsif value > 58
          return 1
        end
      when "zinc"
        if value < 1.275
          return 0.1
        elsif value > 1.275 && value < 2.55
          return 0.6
        elsif value > 2.55
          return 1
        end     
      when "iodine"
        if value < 11.25
          return 0.1
        elsif value > 0.6 && value < 22.5
          return 0.6
        elsif value > 22.5
          return 1
        end 
      when "potassium"
        if value < 262.2
          return 0.1
        elsif value > 262.2 && value < 525
          return 0.6
        elsif value > 525
          return 1
        end   
      when "phosphorus"
        if value < 75
          return 0.1
        elsif value > 75 &&  value < 150
          return 0.6
        elsif value > 150
          return 1
        end 
      when "manganese"
        if value < 0.3
          return 0.1
        elsif value > 0.3 &&  value < 0.6
          return 0.6
        elsif value > 0.6
          return 1
        end 
      when "copper"
        if value < 0.125
          return 0.1
        elsif value > 0.125 &&  value < 0.25
          return 0.6
        elsif value > 0.25
          return 1
        end     
      when "selenium"
        if value < 3
          return 0.1
        elsif value > 3 &&  value < 6
          return 0.6
        elsif value > 6
          return 1
        end   
      when "chloride"
        if value < 221
          return 0.1
        elsif value > 221 && value < 442.5
          return 0.6
        elsif value > 442.5
          return 1
        end 
      when "chromium"
        if value < 3.75
          return 0.1
        elsif value > 3.75 &&  value < 7.5
          return 0.6
        elsif value > 7.5
          return 1
        end   
      end                                       
    end 
  end
end