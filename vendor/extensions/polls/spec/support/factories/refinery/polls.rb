
FactoryGirl.define do
  factory :poll, :class => Refinery::Polls::Poll do
    sequence(:slug) { |n| "refinery#{n}" }
  end
end

