# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#  Mayor.create(name: 'Emanuel', city: cities.first)

# seed parameters
PEOPLE_NUM = 30
UNIV_NUM = 10
PERIOD_MIN_NUM = 1
PERIOD_MAX_NUM = 2
DONG_MIN_NUM = 4
DONG_MAX_NUM = 10
DATE_MIN = 1985
DATE_MAX = 1999
########################

genders = ["male", "female"]
majors = ["physics", "math", "chem", "politics", "economy", "english", "biology", "psycology", "architecture"]

def random_survey_property
    return rand(1..4)
end

def random_survey(survey)
    survey.sociality = random_survey_property
    survey.familiarity = random_survey_property
    survey.awaken = random_survey_property
    survey.smoke = random_survey_property
    survey.game = random_survey_property
    survey.waketime = random_survey_property
    survey.save
end

def random_date
    return Date.new(rand(DATE_MIN..DATE_MAX), 1, 1)
end

#create univs
UNIV_NUM.times do |i|
    univ = Univ.new
    univ.name = 'seed_univ' + i.to_s
    univ.save
    
    dong_num = rand(DONG_MIN_NUM..DONG_MAX_NUM)
    period_num = rand(PERIOD_MIN_NUM..PERIOD_MAX_NUM)
    
    dong_num.times do |j|
        dong = Dong.new
        dong.name = 'seed_dong' + j.to_s
        dong.gender = genders[j%2]
        dong.save
        univ.dongs << dong
    end
    
    period_num.times do |k|
       period = Period.new
       period.name = 'seed_period' + k.to_s
       period.in_progress = true
       period.save
       univ.periods << period
    end
end

#create people and their surveys and pref.surveys.
PEOPLE_NUM.times do |i|
    user = User.new
    user.name = 'seed_user' + i.to_s
    user.email = 'seed_email' + i.to_s + '@a.com'
    user.password = '123123'
    user.password_confirmation = '123123'
    user.gender = genders.sample
    user.major = majors.sample
    user.stage = 4
    user.birth = random_date
    
    univ = Univ.all.sample
    user.univ = univ
    user.dong1 = univ.dongs.where(gender: user.gender).sample
    user.dong2 = univ.dongs.where(gender: user.gender).where.not(id: user.dong1).sample
    user.period1 = univ.periods.sample
    user.period2 = univ.periods.where.not(id: user.period1).sample
    user.save
    
    survey = Survey.new
    random_survey(survey)
    user.survey = survey
    
    preference_survey= PreferenceSurvey.new
    random_survey(preference_survey)
    user.preference_survey = preference_survey
end



