module InheritedResources
  module Actions

    def index
      eval( "@#{resource_class.to_s.downcase.pluralize} = resource_class.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10) ")
    end

  end
end