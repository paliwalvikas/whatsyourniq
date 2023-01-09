
# AdminUser.create(email: 'ft@example.com', password: 'password', password_confirmation: 'password') unless AdminUser.find_by(email: 'ft@example.com')

# BxBlockCatalogue::Product.all.destroy_all
# BxBlockCatalogue::Ingredient.all.delete_all

  products = BxBlockCatalogue::Product.where(data_check: 'red')
  if products.present?
    products.update_all(product_point: nil, product_rating: nil)
  puts "===================== record updatedd ==================="
  end
   
    # BxBlockCatalogue::Product.where(data_check: "green").in_batches.each do |products|
    #   products.each do |object|
    #     if object.image.attached?
    #       if Rails.env.development?
    #         image = Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true)
    #       else
    #         image = object.image&.service_url&.split('?')&.first
    #       end
    #       object.update_columns(image_url: image)
    #     end
    #   end
    # end

