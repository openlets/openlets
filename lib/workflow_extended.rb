module WorkflowExtended
  module ClassMethods
    def workflow_events
      workflow_spec.states.values.collect(&:events).collect(&:keys).flatten.uniq
    end

    def workflow_scopes
      # define scopes for all states
      workflow_spec.states.keys.each do |state|
        scope state, lambda { where :workflow_state => state }
      end
      # define scopes for all states where != state
      workflow_spec.states.keys.each do |state|
        scope "not_#{state}", lambda { where("workflow_state != ?", state) }
      end
      # define scopes for all events, prefixed with 'can_'
      workflow_events.each do |event|
        scope "#{event}able".to_sym, lambda {
          where :workflow_state =>
                    workflow_spec.states.select { |k, s| s.events.include? event }.keys
        }
      end
    end
  end

  def self.included(base)
    base.before_create :state_changed_at_init
    base.extend(ClassMethods)
  end

  def state_changed_at_init
    self.state_changed_at ||= Time.now if respond_to?(:state_changed_at)
    true
  end
end