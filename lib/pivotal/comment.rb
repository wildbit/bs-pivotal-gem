module Pivotal
  class Comment < Model
    attr_accessor :text

    def initialize(id, text)
      self.id = id
      self.text = text
    end
  end
end
