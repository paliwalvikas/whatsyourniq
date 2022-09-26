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
    

    def saturated_fat_clc(saturate_fat, energy)
      if saturate_fat.between?(2,3) && energy.between?(160, 320) || saturate_fat.between?(3,4) && energy.between?(160, 400) || saturate_fat.between?(4,5) && energy.between?(160, 480) || saturate_fat.between?(5,6) && energy.between?(160, 560) || saturate_fat.between?(6,7) && energy.between?(160, 640) || saturate_fat.between?(7,8) && energy.between?(160, 720) || saturate_fat.between?(8,9) && energy.between?(160, 800) || saturate_fat.between?(9,10) && energy.between?(160, 800) || saturate_fat > 10 && energy > 800
        return 'High'
      end 
    end

    def sodium_level_clc(sodium, energy)
      if sodium <= 90 && energy <= 80 || sodium.between?(90,180) && energy.between?(80, 160) || sodium.between?(180,270) && energy.between?(1, 240) || sodium.between?(270, 360) && energy.between?(1, 320) || sodium.between?(360, 450) && energy.between?(1, 400) || sodium.between?(450,540) && energy.between?(1, 480) || sodium.between?(540,630) && energy.between?(1, 560) || sodium.between?(560,720) && energy.between?(1, 640) || sodium.between?(720,810) && energy.between?(1, 720) || sodium.between?(810,900) && energy.between?(1, 800) || sodium > 900 && energy.between?(1, 800) 
        return 'High'
      end 
    end

    def trans_fat_clc(trans_fat, energy)
      if trans_fat == 0.09 && energy.between?(0,80) || trans_fat == 0.09 && energy.between?(0,160) || trans_fat == 0.018 && energy.between?(0,240) || trans_fat == 0.27 && energy.between?(0,320) || trans_fat == 0.36 && energy.between?(0,400) || trans_fat == 0.44 && energy.between?(0,480) || trans_fat == 0.53 && energy.between?(0,560) || trans_fat == 0.62 && energy.between?(0,640) || trans_fat == 0.71 && energy.between?(0,720) || trans_fat == 0.8 && energy.between?(0,800) || trans_fat == 0.89 && energy > 800 
        return 'High' 
      end
    end


    def suger_clc(product_type, sugar, energy)
      case product_type 
        when 'solid'
          if sugar <= 4.5 && energy.between?(0,80) || sugar.between?(4.5, 9) && energy.between?(0,160) || sugar.between?(9, 13.5) && energy.between?(0,240) || sugar.between?(13.5, 18)  && energy.between?(0,320) || sugar.between?(18, 22.5) && energy.between?(0,400) || sugar.between?(22.5, 27) && energy.between?(0,480) || sugar.between?(27, 31) && energy.between?(0,560) || sugar.between?(31, 36) && energy.between?(0,640) || sugar.between?(36, 40) && energy.between?(0,720) || sugar.between?(40, 45) && energy.between?(0,800) || sugar > 45 && energy > 800 
            return 'High'
          end
        when 'beverage'
          if sugar <= 0 && energy <= 0 || sugar <= 1.5 && energy <= 7 || sugar <= 3 && energy <= 14 || sugar <= 4.5 && energy <= 22 || sugar <= 6 && energy <= 29 || sugar <= 7.5 && energy <= 36 || sugar <= 9 && energy <= 43 || sugar <= 10.5 && energy <= 50 || sugar <= 12 && energy <= 57 || sugar <= 13.5 && energy <= 64 || sugar > 13.5 && energy > 64 
            return 'High'
          end
        end
    end

  end
end