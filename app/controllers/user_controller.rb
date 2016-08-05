class UserController < ApplicationController
    def registerProfileInfo
        puts "22222222222########################################################"
        puts current_user.inspect
        user = User.new
        @univinfo = user.univ_info
        # render :json => univinfo.to_json
    end
    
    def registerProfile
        puts "1111111111########################################################"
        puts current_user.inspect
        current_user.register_profile(params.permit(:name,:birth,:univ,:major))
        redirect_to "/"
    end

end
