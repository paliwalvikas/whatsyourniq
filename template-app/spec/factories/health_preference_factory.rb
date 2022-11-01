FactoryGirl.define do
  factory :health_preference, class: BxBlockCatalogue::HealthPreference do
    immunity {true}
    gut_health {true}
    holistic_nutrition {true}
    weight_loss {true}
    weight_gain {true}
    diabetic {true}
    low_cholesterol {true}
    heart_friendly {true}
    energy_and_vitality {true}
    physical_growth {true}
    cognitive_health {true}
    high_protein {true}
    low_sugar {true}
    hyperthyroid {true}
    greater_than_60_years_old {true}
    pregnant_women {true}
    hypothyroid {true}
  end
end
