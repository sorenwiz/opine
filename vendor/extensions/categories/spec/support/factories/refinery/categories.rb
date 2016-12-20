
FactoryGirl.define do
  factory :category, :class => Refinery::Categories::Category do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

