class UserController < ApplicationController
    def registerProfileInfo
        user = User.new
        univinfo = user.univ_info
        render :json => univinfo.to_json
    end
    
    def registerProfile
        redirect_to "/"
    end

end
