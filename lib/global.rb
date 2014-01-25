require 'singleton'

class Settings
  include Singleton

  def initialize
    @data = YAML::load(ERB.new(File.read("#{::Rails.root.to_s}/config/settings.yml")).result)[::Rails.env]
  end

  def [](key)
    key = key.to_s
    ENV[key.upcase] || @data[key]
  end
end
  
GLOBAL ||= Settings.instance