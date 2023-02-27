# frozen_string_literal: true

class CreateChatOptionCategory < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_option_categories do |t|
      t.string :name

      t.timestamps
    end
    add_column :answer_options, :title, :string
    add_column :answer_options, :chat_option_category_id, :bigint
  end
end
