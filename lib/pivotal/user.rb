module Pivotal
  class User < Model
    attr_accessor :username, :initials

    def initialize(id, name, username, initials)
      self.initials = initials
      self.username = username
      super(id, name)
    end

    def matches?(needle)
      [name, username, initials].compact.any? do |identity|
        identity.include?(needle.to_s)
      end
    end
  end
end
