# Load the rails application
require File.expand_path('../application', __FILE__)
CONFIG = YAML.load_file("#{::Rails.root.to_s}/config/config.yml")[::Rails.env].symbolize_keys
# Initialize the rails application
Tp::Application.initialize!
