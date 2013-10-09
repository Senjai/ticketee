FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@example.com"}
  sequence(:name) {|n| "Test User ##{n}"}
  factory :user do
    name { generate(:name) }
    email { generate(:email) }
    password "test"
    password_confirmation "test"

    factory :admin_user do
      admin true
    end
  end
end