class Univ < ActiveRecord::Base
    serialize :metadata, Oj
    
    has_many :users
    has_many :periods
    has_many :dongs
    
    def self.names_as_json
       return self.select(:id, :name).as_json
    end
    
    def as_json
       return super(only: [:id, :name])
    end
end
