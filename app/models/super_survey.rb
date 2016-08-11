class SuperSurvey < ActiveRecord::Base
    self.abstract_class = true
    serialize :metadata, Oj
    
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
    
    def as_json(options={})
        return super(:only => @@questions)
    end
    
    def questions_as_json
       return self.as_json(only: @@questions) 
    end
end