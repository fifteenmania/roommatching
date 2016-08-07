class SuperSurvey < ActiveRecord::Base
    self.abstract_class = true
    @@questions = [:sociality, :familiarity, :awaken, :smoke, :game, :waketime]
    def self.questions
        return @@questions
    end
    
    def random_survey
        self.class.questions.each do |question|
           self[question] = rand(1..4) 
        end
    end
end