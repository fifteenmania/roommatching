class HomeController < ApplicationController
    def index
        is_login = !current_user.nil?
        user_basic_info = is_login ? current_user.basic_info_as_json : nil
        render :json => {is_login: is_login,
                        user: user_basic_info}
    end
    
    def protocall_test
        
    end
end