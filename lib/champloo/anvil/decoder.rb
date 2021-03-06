require 'champloo/anvil/data'
require 'champloo/anvil/location'

module Champloo
  module Anvil
    class Decoder
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
        @data[0, LOCATIONS_SIZE].unpack('N*').map do |x|
          Champloo::Anvil::Location.new(x)
        end
      end

      def decode_timestamps
        @data[LOCATIONS_SIZE, TIMESTAMPS_SIZE].unpack('N*').map do |timestamp|
          Time.at(timestamp)
        end
      end

      def decode_chunks
        header_offset = LOCATIONS_SIZE + TIMESTAMPS_SIZE

        locations = @locations.reject {|l| l.offset.zero? && l.sector_count.zero? }
        locations.sort_by(&:offset).map do |l|
          next nil if l.offset.zero? && l.sector_count.zero?

          offset = l.offset * SECTOR_SIZE
          length, compression_type = @data[offset, 5].unpack('Nc')
          compressed_data = @data[offset + 5, length - 1]

          nbt_decoder_for(compression_type).new(compressed_data)
        end
      end

      def nbt_decoder_for(compression_type)
        case compression_type
        when Champloo::Anvil::COMPRESSION_TYPE_GZIP
          Champloo::NBT::GzipNamedBinaryTag
        when Champloo::Anvil::COMPRESSION_TYPE_ZLIB
          Champloo::NBT::ZlibNamedBinaryTag
        else
          raise "Not supported compression type: #{compression_type}"
        end
      end
    end
  end
end
