class Period < ActiveRecord::Base
    serialize :metadata, Oj
    
    belongs_to :univ
    has_many :users
    
    def as_json(options={})
       return super.as_json(only: [:id, :name]) 
    end
end
