class CreateDongs < ActiveRecord::Migration
  def change
    create_table :dongs do |t|
      t.belongs_to :univ, index: true
      t.string :gender
      t.string :name
      
      t.timestamps null: false
    end
  end
end
