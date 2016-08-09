class HomeController < ApplicationController
    def index
        
    end
    
    def userinfo
        render :json => {is_login: !current_user.nil?, 
                        user: current_user.basic_info_as_json}
    end
end
