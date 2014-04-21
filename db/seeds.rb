{ 'app_name' => 'OpenLETS', 'domain' => 'www.example.com:3000', 'allow_anyone_to_create_economy' => 'false'}.each do |name, value|
  Setting.find_or_create_by_name(name: name, value: value)
end

{ 'allowed_currency_types' => ['fiat', 'mutual_credit', 'backed_by'], 
  'allowed_economy_types'  => ['business', 'community', 'coop', 'non_profit']}.each do |name, array|
  Setting.find_or_create_by_name(name: name, array: array)
end

%w(food fashion art home_improvment body_and_soul kids education for_rent music electronics sport books animals leisure community_activities services transportation).each do |category|
	Category.find_or_create_by_name(name: category)
end