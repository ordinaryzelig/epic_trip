FactoryGirl.define do

  factory :calendar do

    factory :holiday_season do
      after_create { |calendar| FactoryGirl.create(:xmas, calendar: calendar) }
      after_create { |calendar| FactoryGirl.create(:new_years, calendar: calendar) }
    end

  end

end
