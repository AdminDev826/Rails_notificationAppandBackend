Turnout.configure do |config|
  config.app_root = '.'
  config.named_maintenance_file_paths = {default: config.app_root.join('tmp', 'maintenance.yml').to_s}
  config.default_maintenance_page = Turnout::MaintenancePage::HTML
  config.default_reason = "The site is temporarily down for maintenance.\nPlease check back soon."
  config.default_allowed_paths = []
  config.default_response_code = 503
  config.default_retry_after = 7200
end
