require 'pivotal/model'

module Pivotal
  class PivotalError < StandardError; end
  class UnknownStateError < PivotalError; end
  class StoryNotEstimatedError < PivotalError; end

  class Story < Model
    STATES = %w(accepted delivered finished started rejected unstarted unscheduled)

    attr_accessor :state, :estimate, :owned_by_id, :type

    def initialize(id, name, state=nil, estimate=nil, owned_by_id=nil, type=nil)
      super(id, name)
      self.state = state
      self.estimate = estimate
      self.owned_by_id = owned_by_id
      self.type = type
    end

    def self.build(attrs)
      new(attrs['id'], attrs['name'], attrs['current_state'], attrs['estimate'], attrs['owned_by_id'], attrs['story_type'])
    end

    %w(feature bug chore release).each do |type|
      define_method "#{type}?", -> { self.type == type }
    end
  end
end
