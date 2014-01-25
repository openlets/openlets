CarrierWave.configure do |config|

  if GLOBAL[:storage_type] == :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => GLOBAL[:aws_key] || raise('Please provide AWS access key ID'),
      :aws_secret_access_key  => GLOBAL[:aws_secret] || raise('Please provide AWS secret access key')
    }

    config.fog_directory = GLOBAL[:aws_bucket] || 'openlets'
    config.fog_public     = true
    config.fog_attributes = {'Cache-Control' => 'max-age=315576000'}
  end

  config.cache_dir = 'carrierwave'
end