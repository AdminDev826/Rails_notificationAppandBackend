class ApplicationRecord < ActiveRecord::Base

  require 'one_signal'

  include Modules::ModuleSlack

  self.abstract_class = true

end
