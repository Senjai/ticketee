FactoryGirl.define do
  factory :ticket do
    title "Example Ticket"
    description "An example ticket, nothing more"
    association :user, factory: :user
    association :project, factory: :project
  end
end