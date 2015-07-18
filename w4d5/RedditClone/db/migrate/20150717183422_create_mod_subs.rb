class CreateModSubs < ActiveRecord::Migration
  def change
    create_table :mod_subs do |t|
      t.integer :sub_id, null: false
      t.integer :mod_id, null: false

      t.timestamps null: false
    end

    add_index :mod_subs, :sub_id
    add_index :mod_subs, :mod_id
  end
end
