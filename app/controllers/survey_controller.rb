class SurveyController < ApplicationController
    def new
        
    end
    
    def create
        survey = Survey.new(survey_params)
        preference_survey = PreferenceSurvey.new(preference_survey_params)
        survey.save
        preference_survey.save
        redirect_to "/survey"
    end
    
    def edit
        survey = current_user.survey
        preference_survey = current_user.preference_survey
        
        render :json => {survey: survey.as_json(only: [:sociality, :familiarity, :awaken, :smoke, :game, :waketime]),
            preference_survey: preference_survey.as_json(only: [:sociality, :familiarity, :awaken, :smoke, :game, :waketime])}
    end
    
    def update
        survey = current_user.survey
        preference_survey = current_user.preference_survey
        survey.update(survey_params)
        preference_survey.update(preference_survey_params)
        
        survey.save
        preference_survey.save
    end
    
    private
        def survey_params
            params.require(:survey).permit(:sociality, :familiarity, :awaken, :smoke, :game, :waketime)
        end
        def preference_survey_params
            params.require(:preference_survey).permit(:sociality, :familiarity, :awaken, :smoke, :game, :waketime)
        end 
end
