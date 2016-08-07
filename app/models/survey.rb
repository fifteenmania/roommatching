class Survey < SuperSurvey
    belongs_to :user, dependent: :destroy
end
