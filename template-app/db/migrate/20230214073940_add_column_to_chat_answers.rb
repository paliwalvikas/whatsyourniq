class AddColumnToChatAnswers < ActiveRecord::Migration[6.0]
  def change
    add_column :chats, :answer_type, :integer, default: 0
  end

  def up
    remove_column :chats, :radio
  end

  def down
    add_column :chats, :radio, :boolean
  end
end
