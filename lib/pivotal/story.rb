require 'pivotal/model'

module Pivotal
  class UnknownStateError < StandardError; end

  class Story < Model
    STATES = %w(accepted delivered finished started rejected unstarted unscheduled)

    attr_accessor :state, :estimate

    def initialize(id, name, state=nil, estimate=nil)
      super(id, name)
      self.state = state
      self.estimate = estimate
    end
  end
end
