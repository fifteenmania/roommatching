class Dong < ActiveRecord::Base
    belongs_to :univ, dependent: :destroy
    has_many :users
end
