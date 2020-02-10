require 'active_record'
require_relative './test_app/models/pageview.rb'
require_relative './test_app/models/visit.rb'

require './test_app/services/http_service.rb'
require './test_app/services/business_service.rb'
  
def db_configuration
  db_configuration_file = File.join(File.expand_path('..', __FILE__), '..', 'db', 'config.yml')
  YAML.load(File.read(db_configuration_file))
end


def call
  BusinessService.new.logic
end
