FactoryGirl.define do

  factory :event do

    factory :xmas do
      started_on Date.civil(Date.today.year, 12, 25)
      ended_on   { started_on }
      name 'Christmas'
    end

    factory :new_years do
      started_on Date.civil(Date.today.year + 1, 1, 1)
      ended_on   { started_on }
      name 'New Years'
    end

  end

end
