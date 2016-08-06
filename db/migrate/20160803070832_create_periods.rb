class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.belongs_to :univ, index: true
      t.string :name
      t.boolean :in_progress

      t.timestamps null: false
    end
  end
end
