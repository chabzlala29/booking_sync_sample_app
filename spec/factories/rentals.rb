FactoryGirl.define do
  factory :rental do
    name { FFaker::Company.name }
  end
end
