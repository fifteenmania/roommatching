class CreateDongs < ActiveRecord::Migration
  def change
    create_table :dongs do |t|
      t.integer :univ_id
      t.string :gender
      t.string :name
      
      t.timestamps null: false
    end
  end
end
