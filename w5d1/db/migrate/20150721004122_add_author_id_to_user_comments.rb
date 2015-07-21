class AddAuthorIdToUserComments < ActiveRecord::Migration
  def change
    add_column :user_comments, :author_id, :integer, index: true, null: false
  end
end
