module TransactionableHelper

  def category_labels_for(resource)
    resource.categories.map(&:name).map { |name| content_tag(:span, name, class: 'label radius') }.join(" ").html_safe
  end

end