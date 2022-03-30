# frozen_string_literal: true

# Allows for some 'magic' in being able to initialize and run a process in one command.
# This is achieved by storing the kwargs as a hash internally, and using method missing to access a
# value from that hash if it exists.
# This removes some boilerplate from services by removing the need to define an initializer and
# attribute accessors.
class Service
  def self.call(**args)
    new(**args).call
  end

  def initialize(params = {})
    @__params = params
  end

  private

  attr_reader :__params

  def method_missing(method_name, *args, &block)
    if __params.key?(method_name)
      __params[method_name]
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    __params.key?(method_name) || super
  end
end
