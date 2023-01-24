class NotificationPolymorphic < ActiveRecord::Migration[6.0]

  def up
    change_table :notifications do |t|
      t.references :notificable, polymorphic: true
    end
  end

  def down
    change_table :notifications do |t|
      t.remove_references :notificable, polymorphic: true
    end
  end

end
