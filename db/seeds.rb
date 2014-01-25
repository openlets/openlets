{'registration_gift' => 100, 'facebook_login_gift' => 20, 
	'google_oauth2_login_gift' => 15, 'linkedin_login_gift' => 10,
	'first_item_with_image_gift' => 30, 'first_item_gift' => 20, 
	'new_item_gift' => 5, 'currency_name' => 'dodo',
  'community_name' => 'OpenLETS'}.each do |name, value|
  Setting.find_or_create_by_name(name: name, value: value)
end

%w(food fashion art home_improvment body_and_soul kids education for_rent music electronics sport books animals leisure community_activities services transportation).each do |category|
	Category.find_or_create_by_name(name: category)
end

# Subcategories

# %w(kitchenware workshops books fruits_and_vegies cooked_meals diet).each do |name|
# 	parent = Category.find_by_name('food')
# 	Category.find_or_create_by_name(name: name, parent_id: parent.id)
# end

# %w(materials artwork dance lessons courses).each do |name|
# 	parent = Category.find_by_name('food')
# 	Category.find_or_create_by_name(name: name, parent_id: parent.id)
# end