require 'pivotal/model'

module Pivotal
  class UnknownStateError < StandardError; end

  class Story < Model
    STATES = %w(accepted delivered finished started rejected unstarted unscheduled)

    attr_accessor :state, :estimate, :owned_by_id

    def initialize(id, name, state=nil, estimate=nil, owned_by_id=nil)
      super(id, name)
      self.state = state
      self.estimate = estimate
      self.owned_by_id = owned_by_id
    end
  end
end
