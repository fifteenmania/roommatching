class UserController < ApplicationController
    def registerProfileInfo
        # puts current_user.inspect
        user = User.new
        @univinfo = user.univ_info
        # render :json => univinfo.to_json
    end
    
    def registerProfile
        # puts current_user.inspect
        current_user.register_profile(profile_params)
        redirect_to "/"
    end
    
    def ProfileInfo
        myinfo = current_user.profile_info
        render :json => myinfo.to_json
    end
    
    def updateProfile
        current_user.register_profile(profile_params)
        redirect_to "/"
    end
    
    def dormSurveyInfo
        dorminfo = current_user.dorm_survey_info
        render :json => dorminfo.to_json
    end
    
    def updateDormSurvey
        current_user.update_dorm_survey(params.permit(:dong1_id,:dong2_id,:period1_id,:period2_id))
        redirect_to "/"
    end
    
    private
        def profile_params
            params.permit(:name,:birth,:univ,:major)
        end
end
