module Pivotal
  class Model
    attr_accessor :id, :name

    def initialize(id, name)
      self.id = id
      self.name = name
    end

    def to_s
      name
    end
  end
end
