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
        @anvil.chunks.map {|chunk_nbt|
          next "\x00".force_encoding(Encoding::BINARY) * SECTOR_SIZE if chunk_nbt.nil?
          encode_chunk(chunk_nbt)
        }.join
      end

      def encode_chunk(chunk_nbt)
        compressed_data  = chunk_nbt.to_binary
        compression_type = compression_type_for(chunk_nbt)
        chunk_header     = [compressed_data.bytesize + 1, compression_type].pack('Nc')
        padding(chunk_header + compressed_data)
      end

      def compression_type_for(nbt)
        case nbt
        when Champloo::NBT::GzipNamedBinaryTag
          Champloo::Anvil::COMPRESSION_TYPE_GZIP
        when Champloo::NBT::ZlibNamedBinaryTag
          Champloo::Anvil::COMPRESSION_TYPE_ZLIB
        else
          raise "Not supported NBT type: #{nbt.class.name}"
        end
      end

      def padding(bytes)
        r = bytes.bytesize % SECTOR_SIZE

        if r.nonzero?
          bytes << "\x00".force_encoding(Encoding::BINARY) * (SECTOR_SIZE - r)
        end

        bytes
      end
    end
  end
end
