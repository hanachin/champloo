require 'delegate'
require 'champloo/anvil'

module Champloo
  class Region < SimpleDelegator
    class << self
      def read(file_path)
        new(File.binread(file_path))
      end
    end

    def initialize(data)
      super(Champloo::Anvil::Decoder.decode(data))
    end

    def to_binary
      Champloo::Anvil::Encoder.encode(self.__getobj__)
    end
  end
end
