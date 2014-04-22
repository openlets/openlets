class Admin::SettingsController < Admin::ResourceController

  before_filter :clean_select_multiple_params, only: :mass_update

  def index
    render (current_economy ? 'economy_settings' : 'app_settings')
  end

  def mass_edit
    @settings = Setting.all
  end

  def mass_update
    @settings = Setting.update(params[:settings].keys, params[:settings].values).reject { |p| p.errors.empty? }
    if @settings.empty?
      flash[:notice] = "Settings updated"
      redirect_to admin_settings_path
    else
      @settings = @settings.concat(Setting.all - Setting.where(id: @settings.map(&:id)))
      render "mass_edit"
    end
  end

  private

    def clean_select_multiple_params hash = params
      hash.each do |k, v|
        case v
        when Array then v.reject!(&:blank?)
        when Hash then clean_select_multiple_params(v)
        end
      end
    end


end