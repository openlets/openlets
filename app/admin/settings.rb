ActiveAdmin.register Setting do
  menu :parent => 'Configurations'
  actions :all, :except => [:destroy, :new, :create]

end
