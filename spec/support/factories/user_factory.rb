FactoryGirl.define do
  factory :user do
    name "Mister Beans"
    email "me@beans.com"
    password "test"
    password_confirmation "test"
  end
end