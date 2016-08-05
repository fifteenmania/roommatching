class UserFacebookProperty < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :image, :string
    add_column :users, :name, :string
    add_column :users, :gender, :string
    add_column :users, :major, :string
    add_column :users, :univ_id, :integer
    add_column :users, :stage, :integer
    add_column :users, :birth, :date
    add_column :users, :dong1_id, :integer
    add_column :users, :dong2_id, :integer
    add_column :users, :period1_id, :integer
    add_column :users, :period2_id, :integer
  end
end
