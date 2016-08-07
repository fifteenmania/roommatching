class PreferenceSurvey < SuperSurvey
    belongs_to :user, dependent: :destroy
end
