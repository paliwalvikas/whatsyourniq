module BxBlockCatalogue
  class FavouriteSearch < BxBlockCatalogue::ApplicationRecord
    self.table_name = :favourite_searches

    belongs_to :account, class_name: 'AccountBlock::Account', optional: true
    serialize :product_category
    serialize :product_sub_category
    serialize :functional_preference
    before_create :inc_added_count, if: :check?
    # after_create :update_product_count, if: :check?
    after_destroy :update_all_records
    validate :check_dupicate , :on => [ :create, :update ]

    scope :product_category, ->(product_category) { where product_category: product_category }
    scope :product_sub_category, ->(product_sub_category) { where product_sub_category: product_sub_category }
    scope :niq_score, ->(niq_score) { where niq_score: niq_score }
    scope :food_allergies, ->(food_allergies) { where food_allergies: food_allergies }
    scope :food_preference, ->(food_preference) { where food_preference: food_preference }
    scope :favourite, ->(favourite) { where favourite: favourite }
    scope :functional_preference, ->(functional_preference) { where functional_preference: functional_preference }

    def inc_added_count
      self.added_count = account&.favourite_searches&.where(favourite: true)&.count + 1
    end

    def check_dupicate
      fav_search = account.favourite_searches.where(favourite: true) if account.present? && favourite
      if fav_search.present?
        fav = fav_search.where(niq_score: niq_score, food_allergies: food_allergies,
                                                              health_preference: health_preference, food_type: food_type, account_id: account_id, food_preference: food_preference) if account.present?

        fav_ids = check_fav?(fav)
        resp = for_json_fields(fav_search)
        paire = conditions_for_duplicate(resp[:p_cat], resp[:p_s_cat], resp[:f_p])
        final = paire & fav.ids

        if final.present?
          error_msg
        elsif fav.present? && fav_ids.present? && (niq_score.present? || food_allergies.present? || health_preference.present? || food_type.present? || account_id.present? || food_preference.present?) && !product_category.present? && !product_sub_category.present? && !functional_preference.present?
          error_msg
        end

      end
    end

    def for_json_fields(fav_search)
      has = {}
      has[:p_cat] = fav_search.pluck(:product_category, :id).map { |i|
         i.last if i.include?(product_category)} if product_category.present?
      has[:p_s_cat] = fav_search.pluck(:product_sub_category, :id).map { |i|
         i.last if i.include?(product_sub_category)} if product_sub_category.present?
      has[:f_p] = fav_search.pluck(:functional_preference, :id).map { |i|
         i.last if i.include?(functional_preference)} if functional_preference.present?
      has
    end

    def check_fav?(fav)
      ids = fav.pluck(:product_category, :product_sub_category, :functional_preference, :id).map { |a|
           a[3] if a[0].blank? && a[1].blank? && a[2].blank?
          }
      fav.where(id: ids, niq_score: niq_score, food_allergies: food_allergies,
                                health_preference: health_preference, food_type: food_type, account_id: account_id, food_preference: food_preference)
    end

    def error_msg
      errors.add(:message, 'please select uniq filters')
    end

    def check?
      account_id.present?
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
      if product_category.present? && product_sub_category.present? && functional_preference.present?
        paire = p_cat & f_p & p_s_cat
      elsif product_category.present? && functional_preference.present?
        paire = p_cat & f_p
      elsif product_sub_category.present? && functional_preference.present?
        paire = p_s_cat & f_p
      elsif product_sub_category.present? && product_category.present?
        paire = p_s_cat & p_cat
      elsif product_sub_category.present?
        paire = p_s_cat
      elsif product_category.present?
        paire = p_cat
      elsif functional_preference.present?
        paire = f_p
      end
      paire
    end

  end
end
