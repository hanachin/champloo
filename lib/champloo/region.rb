module Champloo
  class Region
    COMPRESSION_TYPE_GZIP = 1
    COMPRESSION_TYPE_ZLIB = 2

    attr_reader :data

    class << self
      def read(file_path)
        new(File.binread(file_path))
      end
    end

    def initialize(data)
      @data = RegionDecoder.decode(data)
    end
  end
end
