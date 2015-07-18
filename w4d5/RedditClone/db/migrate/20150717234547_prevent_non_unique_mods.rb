class PreventNonUniqueMods < ActiveRecord::Migration
  def change
    add_index :mod_subs, [:mod_id, :sub_id], unique: true
  end
end
