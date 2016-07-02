require 'delegate'
require 'champloo/anvil_decoder'
require 'champloo/anvil_encoder'

module Champloo
  class Anvil < SimpleDelegator
    COMPRESSION_TYPE_GZIP = 1
    COMPRESSION_TYPE_ZLIB = 2

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
