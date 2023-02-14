class AddColumnToAnswerOption < ActiveRecord::Migration[6.0]
  def change
  	add_column :chats, :radio, :boolean, default: false
  	BxBlockChat::Chat.all&.map{ |val| val.update(radio:  false) }
  end
end
