SimpleForm.setup do |config|

  config.wrappers :default, class: :input,
    hint_class: :field_with_hint, error_class: :field_with_errors do |b|

    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label_input
    b.use :hint,  wrap_with: { tag: :span, class: :hint }
    b.use :error, wrap_with: { tag: :span, class: :error }
  end

  config.wrappers :foundation_inline, class: :input, hint_class: :field_with_hint, error_class: :error do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.wrapper :my_wrapper, tag: :div, class: 'row' do |c|
      c.use :label, wrap_with: {tag: :div, class: 'large-3 small-3 columns'}
      c.wrapper tag: :div, class: 'large-9 small-9 columns' do |d|
        d.use :input
        d.use :error, wrap_with: { tag: :small, class: 'error' }
      end
    end
  end

  config.boolean_style = :nested
  config.error_notification_tag = :div
  config.browser_validations = false
  config.label_class ='inline'
  config.button_class = 'button expand radius'
  config.error_notification_class = 'alert-box alert'
  
  config.default_wrapper = :default
end
