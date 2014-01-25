FactoryGirl.define do
  factory :user do
    password { '123123qwe' }
    email { "email-#{rand(1000000)}@example.com" }
  end
end