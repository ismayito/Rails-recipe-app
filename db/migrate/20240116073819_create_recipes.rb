class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.time :preparation_time
      t.time :cooking_time
      t.text :description
      t.boolean :public
      t.integer :user_id

      t.timestamps
    end
    add_index :recipes, :user_id
  end
end
