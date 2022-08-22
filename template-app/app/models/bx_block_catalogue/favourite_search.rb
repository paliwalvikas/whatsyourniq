module BxBlockCatalogue
  class FavouriteSearch < BxBlockCatalogue::ApplicationRecord
    self.table_name = :favourite_searches

    belongs_to :account, class_name: 'AccountBlock::Account', optional: true
    serialize :product_category
    serialize :product_sub_category
    serialize :functional_preference
    before_create :inc_added_count, if: :check?
    after_create :update_product_count, if: :check?
    after_destroy :update_all_records
    validate :check_dupicate, :on => :create

    scope :product_category, ->(product_category) { where product_category: product_category }
    scope :product_sub_category, ->(product_sub_category) { where product_sub_category: product_sub_category }
    scope :niq_score, ->(niq_score) { where niq_score: niq_score }
    scope :food_allergies, ->(food_allergies) { where food_allergies: food_allergies }
    scope :food_preference, ->(food_preference) { where food_preference: food_preference }
    scope :favourite, ->(favourite) { where favourite: favourite }
    scope :functional_preference, ->(functional_preference) { where functional_preference: functional_preference }
    
    def inc_added_count
      self.added_count = account&.favourite_searches&.where(favourite: true).count+1
    end

    def check_dupicate
      fav_search = account.favourite_searches.where(favourite: true) if account.present?
      if val_present?(fav_search)
        fav = fav_search.where(niq_score: self.niq_score,food_allergies: self.food_allergies, health_preference: self.health_preference, food_type: self.food_type, account_id: self.account_id, food_preference: self.food_preference) if val_present?(self.account)
        p_cat = fav_search.pluck(:product_category, :id).map{|i| i.last if i.include?(self.product_category)} if val_present?(self.product_category)
        p_s_cat = fav_search.pluck(:product_sub_category, :id).map{|i| i.last if i.include?(self.product_sub_category)} if val_present?(self.product_sub_category)
        f_p = fav_search.pluck(:functional_preference, :id).map{|i| i.last if i.include?(self.functional_preference)} if val_present?(self.functional_preference)
        paire = conditions_for_duplicate(p_cat, p_s_cat, f_p)
        final  = paire & fav.ids
        if final.present? 
          error_msg
        elsif fav.present? && (self.niq_score.present? || self.food_allergies.present? || self.health_preference.present? || self.food_type.present? ||  self.account_id.present? ||  self.food_preference.present?) && !val_present?(self.product_category) && !val_present?(self.product_sub_category) && !val_present?(self.functional_preference)
          error_msg
        end
      end
    end

    def error_msg
      errors.add(:message, "please select uniq filters")
    end

    def update_product_count
      prod = BxBlockCatalogue::SmartSearchService.new.smart_search(self)
      prod.present? ? self.update(product_count: prod.count) : self.update(product_count: 0)
    end

    def check?
      self.account_id.present?
    end

    def update_all_records
      if account.present?
        favourite = account&.favourite_searches&.order(updated_at: :asc)
        count = favourite.count
        favourite.each do |i|
          i.update(added_count: count) 
          count = count - 1
        end
      end
    end

    def conditions_for_duplicate(p_cat, p_s_cat, f_p)
      if val_present?(self.product_category) && val_present?(self.product_sub_category) && val_present?(self.functional_preference)
         paire = p_cat & f_p & p_s_cat
      elsif val_present?(self.product_category) && val_present?(self.functional_preference)
        paire = p_cat & f_p
      elsif val_present?(self.product_sub_category) && val_present?(self.functional_preference)
        paire =  p_s_cat & f_p
      elsif self.product_sub_category.present? && val_present?(self.product_category) 
        paire = p_s_cat & p_cat
      elsif val_present?(self.product_sub_category)
        paire = p_s_cat
      elsif val_present?(self.product_category)
        paire = p_cat
      elsif val_present?(self.functional_preference)
        paire = f_p
      end
      paire
    end

    def val_present?(val)
      val.present?
    end

  end
end
