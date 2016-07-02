module Champloo
  class AnvilEncoder
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
      data.locations.map {|loc| (loc.fetch(:offset) << 8) | loc.fetch(:sector_count) }.pack('N*')
    end

    def encode_timestamps
      data.timestamps.map {|time| time.to_i }.pack('N*')
    end

    def encode_chunks
      data.chunks.map {|nbt|
        next "\x00".force_encoding(Encoding::BINARY) * 4096 if nbt.nil?
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
        bytes + "\x00".force_encoding(Encoding::BINARY) * (4096 - bytes.bytesize.divmod(4096).last)
      }.join
    end

    def data
      @anvil.__getobj__
    end
  end
end
