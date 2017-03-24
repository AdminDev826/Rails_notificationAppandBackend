# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Initialize default meta tags
DEFAULT_META = YAML.load_file("#{Rails.root}/config/meta.yml")
