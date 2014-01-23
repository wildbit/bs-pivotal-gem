require 'pivotal/model'

module Pivotal
  class Project < Model
    attr_accessor :account_id

    def initialize(id, name, account_id)
      self.account_id = account_id
      super(id, name)
    end
  end
end
