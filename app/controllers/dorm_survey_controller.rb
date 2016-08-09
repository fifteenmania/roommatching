class DormSurveyController < ApplicationController
    def new
        univ = current_user.univ
        dorms = univ.dongs.where(gender: current_user.gender)
        periods = univ.periods.where(in_progress: true)
        render :json => {dorms: dorms.as_json(only: [:id, :name]), 
                        periods: periods.as_json(only: [:id, :name])}
    end
    
    def craete
        current_user.update(dorm_survey_params)
        current_user.save
        redirect_to root_path
    end
    
    def edit
        univ = current_user.univ
        dorms = univ.dongs.where(gender: current_user.gender)
        periods = univ.periods.where(in_progress: true)
        render :json => {dorms: dorms.as_json(only: [:id, :name]), 
                        periods: periods.as_json(only: [:id, :name])}
    end
    
    def update
        current_user.update(dorm_survey_params)
        current_user.save
        redirect_to root_path
    end
    
    private
        def dorm_survey_params
            # id위조 방지 위해 id범위 제한하는 코드 추가
            params.require(user).permit(:dong1_id,:dong2_id,:period1_id,:period2_id)
        end
end
