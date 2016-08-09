class MatchController < ApplicationController
    def show
       user_matches = current_user.find_match
       
    end
end
