module Champloo
  module Anvil
    class Encoder
      class << self
        def encode(anvil)
          new(anvil).encode
        end
      end

      def initialize(anvil)
        @anvil = anvil
      end

      def encode
        encode_locations + encode_timestamps + encode_chunks
      end

      def encode_locations
        @anvil.locations.map {|loc| (loc.fetch(:offset) << 8) | loc.fetch(:sector_count) }.pack('N*')
      end

      def encode_timestamps
        @anvil.timestamps.map {|time| time.to_i }.pack('N*')
      end

      def encode_chunks
        @anvil.chunks.map {|nbt|
          next "\x00".force_encoding(Encoding::BINARY) * SECTOR_SIZE if nbt.nil?
          compressed_data = nbt.to_binary
          compression_type =
            case nbt
            when Champloo::NBT::GzipNamedBinaryTag
              Champloo::Anvil::COMPRESSION_TYPE_GZIP
            when Champloo::NBT::ZlibNamedBinaryTag
              Champloo::Anvil::COMPRESSION_TYPE_ZLIB
            else
              raise "Not supported NBT type: #{nbt.class.name}"
            end
          bytes = [compressed_data.bytesize + 1, compression_type].pack('Nc') + compressed_data

          # padding
          padding = bytes.bytesize.divmod(SECTOR_SIZE).last
          if padding.nonzero?
            bytes << "\x00".force_encoding(Encoding::BINARY) * (SECTOR_SIZE - padding)
          end

          bytes
        }.join
      end
    end
  end
end
