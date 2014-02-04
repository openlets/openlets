{ 'currency_name' => 'dodo', 'maximum_debit' => '-100',
  'community_name' => 'OpenLETS'}.each do |name, value|
    Setting.find_or_create_by_name(name: name, value: value)
end

%w(food fashion art home_improvment body_and_soul kids education for_rent music electronics sport books animals leisure community_activities services transportation).each do |category|
	Category.find_or_create_by_name(name: category)
end