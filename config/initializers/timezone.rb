Rails.application.configure do |config|
  config.time_zone = 'Tokyo'
  config.active_record.default_timezone = :local
end
