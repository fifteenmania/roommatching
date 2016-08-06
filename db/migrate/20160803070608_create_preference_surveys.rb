class CreatePreferenceSurveys < ActiveRecord::Migration
  def change
    create_table :preference_surveys do |t|
      t.belongs_to :user, index: true
      t.integer :sociality
      t.integer :familiarity
      t.integer :awaken
      t.integer :smoke
      t.integer :game
      t.integer :waketime
      
      t.timestamps null: false
    end
  end
end
