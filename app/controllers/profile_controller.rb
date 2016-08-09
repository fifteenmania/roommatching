class ProfileController < ApplicationController
    def new
        render :json => {user: current_user.profile_as_json, 
                        univs: Univ.names_as_json}
    end
    
    def create
        current_user.update(profile_params)
        current_user.save
        redirect_to root_path
    end
    
    def edit
        render :json => {user: current_user.profile_as_json,
                        univs: Univ.names_as_json}
    end
    
    def update
        current_user.update(profile_params)
        current_user.save
        redirect_to root_path
    end
    
    private
        def profile_params
            params.require(:user).permit(:name, :birth, :univ, :major)
        end
end
