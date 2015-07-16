class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name, null: false
      t.date :birth_date
      t.string :color, null: false
      t.string :sex
      t.text :description

      t.timestamps null: false
    end
  end
end
