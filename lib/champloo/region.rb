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
      super(AnvilDecoder.decode(data))
    end

    def to_binary
      AnvilEncoder.encode(self)
    end
  end
end
