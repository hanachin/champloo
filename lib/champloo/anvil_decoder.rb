module Champloo
  class AnvilDecoder
    MAX_CHUNK_NUM = 1024
    SECTOR_SIZE = 1024 * 4
    LOCATIONS_SIZE = 1024 * 4
    TIMESTAMPS_SIZE = 1024 * 4

    class << self
      def decode(data)
        new(data).decode
      end
    end

    def initialize(data)
      @data = data
    end

    def decode
      @locations = decode_locations
      @timestamps = decode_timestamps
      @chunks = decode_chunks

      Champloo::Anvil::Data.new(@locations, @timestamps, @chunks)
    end

    def decode_locations
      @data[0, LOCATIONS_SIZE].unpack('N*').map do |bytes|
        offset = bytes >> 8
        sector_count = bytes & 0xFF
        {offset: offset, sector_count: sector_count}
      end
    end

    def decode_timestamps
      @data[LOCATIONS_SIZE, TIMESTAMPS_SIZE].unpack('N*').map do |timestamp|
        Time.at(timestamp)
      end
    end

    def decode_chunks
      header_offset = LOCATIONS_SIZE + TIMESTAMPS_SIZE

      @locations.map do |l|
        next nil if l[:offset].zero? && l[:sector_count].zero?

        offset = l[:offset] * SECTOR_SIZE
        length, compression_type = @data[offset, 5].unpack('Nc')
        compressed_data = @data[offset + 5, length - 1]

        case compression_type
        when Champloo::Anvil::COMPRESSION_TYPE_GZIP
          Champloo::NBT::GzipNamedBinaryTag.new(compressed_data)
        when Champloo::Anvil::COMPRESSION_TYPE_ZLIB
          Champloo::NBT::ZlibNamedBinaryTag.new(compressed_data)
        else
          raise "Not supported compression type: #{compression_type}"
        end
      end
    end
  end
end
