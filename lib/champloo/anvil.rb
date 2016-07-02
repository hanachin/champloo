module Champloo
  class Anvil
    COMPRESSION_TYPE_GZIP = 1
    COMPRESSION_TYPE_ZLIB = 2

    attr_reader :data

    class << self
      def read(file_path)
        new(File.binread(file_path))
      end
    end

    def initialize(data)
      @data = AnvilDecoder.decode(data)
    end

    def to_binary
      AnvilEncoder.encode(self)
    end
  end
end
