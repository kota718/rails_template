Rails.application.config do |c|
  c.time_zone = 'Tokyo'
  c.active_record.default_timezone = :local
end
