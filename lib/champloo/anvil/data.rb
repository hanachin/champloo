require 'delegate'

module Champloo
  class Anvil < SimpleDelegator
    Data = Struct.new(:locations, :timestamps, :chunks)
  end
end
