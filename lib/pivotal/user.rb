module Pivotal
  class User < Model
    attr_accessor :username, :initials

    def initialize(id, name, username, initials)
      self.initials = initials
      self.username = username
      super(id, name)
    end

    def matches?(needle)
      return false if needle.nil?

      [name, username, initials].compact.any? do |identity|
        identity.downcase.include?(needle.downcase)
      end
    end
  end
end
