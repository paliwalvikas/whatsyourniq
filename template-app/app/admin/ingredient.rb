# frozen_string_literal: true

ActiveAdmin.register BxBlockCatalogue::Ingredient, as: 'ingredient' do
  permit_params :id, :product_id, :energy, :saturate, :total_sugar, :sodium, :ratio_fatty_acid_lipids, :fibre, :fruit_veg,
                :protein, :vit_a, :vit_c, :vit_d, :vit_b6, :vit_b12, :vit_b9, :vit_b2, :vit_b3, :vit_b1, :vit_b5, :vit_b7, :calcium, :iron, :magnesium, :zinc, :iodine, :potassium, :phosphorus, :manganese, :copper, :selenium, :chloride, :chromium

  filter :product_id, as: :select, collection: BxBlockCatalogue::Product.all.pluck(:id)
  filter :energy
  filter :saturate
  filter :total_sugar
  filter :ratio_fatty_acid_lipids
  filter :fruit_veg
  filter :protein
  filter :vit_a
  filter :vit_c
  filter :vit_d
  filter :vit_b6
  filter :vit_b12
  filter :vit_b9
  filter :vit_b2
  filter :vit_b3
  filter :vit_b1
  filter :vit_b5
  filter :vit_b7
  filter :calcium
  filter :iron
  filter :magnesium
  filter :zinc
  filter :iodine
  filter :potassium
  filter :phosphorus
  filter :manganese
  filter :copper
  filter :selenium
  filter :chloride
  filter :chromium
  filter :sodium
  filter :fibre

  form do |f|
    f.inputs do
      f.input :product_id, as: :select, collection: BxBlockCatalogue::Product.all.pluck(:product_name, :id)
      f.input :energy
      f.input :saturate
      f.input :total_sugar
      f.input :ratio_fatty_acid_lipids
      f.input :fruit_veg
      f.input :protein
      f.input :vit_a
      f.input :vit_c
      f.input :vit_d
      f.input :vit_b6
      f.input :vit_b12
      f.input :vit_b9
      f.input :vit_b2
      f.input :vit_b3
      f.input :vit_b1
      f.input :vit_b5
      f.input :vit_b7
      f.input :calcium
      f.input :iron
      f.input :magnesium
      f.input :zinc
      f.input :iodine
      f.input :potassium
      f.input :phosphorus
      f.input :manganese
      f.input :copper
      f.input :selenium
      f.input :chloride
      f.input :chromium
      f.input :fibre
      f.input :sodium
    end
    f.actions
  end

  index title: 'ingredient' do
    id_column
    column :energy
    column :saturate
    column :total_sugar
    column :ratio_fatty_acid_lipids
    column :fruit_veg
    column :protein
    column :vit_a
    column :vit_c
    column :vit_d
    column :vit_b6
    column :vit_b12
    column :vit_b9
    column :vit_b2
    column :vit_b3
    column :vit_b1
    column :vit_b5
    column :vit_b7
    column :calcium
    column :iron
    column :magnesium
    column :zinc
    column :iodine
    column :potassium
    column :phosphorus
    column :manganese
    column :copper
    column :selenium
    column :chloride
    column :chromium
    column :sodium
    column :fibre
    column 'product' do |object|
      object&.product&.product_name
    end
    actions
  end

  show do
    attributes_table do
      row :energy
      row :saturate
      row :total_sugar
      row :ratio_fatty_acid_lipids
      row :fruit_veg
      row :protein
      row :vit_a
      row :vit_c
      row :vit_d
      row :vit_b6
      row :vit_b12
      row :vit_b9
      row :vit_b2
      row :vit_b3
      row :vit_b1
      row :vit_b5
      row :vit_b7
      row :calcium
      row :iron
      row :magnesium
      row :zinc
      row :iodine
      row :potassium
      row :phosphorus
      row :manganese
      row :copper
      row :selenium
      row :chloride
      row :chromium
      row :sodium
      row :fibre
    end
  end
end
