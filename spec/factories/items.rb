FactoryGirl.define do
  factory :item do
    title { "item-#{rand(1000000)}"}
    description { "cool item" }
    price { 50 }
  end
end