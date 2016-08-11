class MatchesController < ApplicationController
    def show
        render :json => current_user.find_matches_as_json
    end
end
