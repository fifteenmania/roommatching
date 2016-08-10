class SuperSurvey < ActiveRecord::Base
    self.abstract_class = true
    @@questions = [:sociality, :familiarity, :awaken, :smoke, :game, :waketime]
    
    def self.questions
        return @@questions
    end
    
    def self.questions_num
       return @@questions.length
    end
    
    def random_survey
        self.class.questions.each do |question|
           self[question] = rand(1..4)
        end
    end
    
    def questions_as_json
       return self.as_json(only: @@questions) 
    end
    
    def to_builder
        Jbuilder.new do |survey|
           survey.(self, :sociality, :familiarity, :awaken, :smoke, :game, :waketime) 
        end
    end
end