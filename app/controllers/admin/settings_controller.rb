class Admin::SettingsController < Admin::ResourceController

  def index
    render (current_economy ? 'economy_settings' : 'system_settings')
  end
end