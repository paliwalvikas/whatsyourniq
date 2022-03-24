class ReNameFollowersToCurrentUser < ActiveRecord::Migration[6.0]
  def change
    rename_column :follows, :followable_id, :current_user_id
  end
end
