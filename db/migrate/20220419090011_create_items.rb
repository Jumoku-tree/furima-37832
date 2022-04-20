class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title,      null: false
      t.text :about,        null: false
      t.integer :price,     null: false
      t.integer :charge_id, null: false
      t.integer :condition_id,  null: false
      t.integer :till_id,   null: false
      t.integer :prefecture_id, null: false
      t.references :user,   null: false, foreign_key: true
      t.timestamps
    end
  end
end
