class Univ < ActiveRecord::Base
    serialize :metadata, Oj
    
    has_many :users
    has_many :periods
    has_many :dongs
    
    def self.names_as_json
       return self.all.as_json(only: [:id, :name])
    end
end
