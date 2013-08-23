FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@example.com"}
  factory :user do
    name "Mister Beans"
    email { generate(:email) }
    password "test"
    password_confirmation "test"

    factory :admin_user do
      admin true
    end
  end
end