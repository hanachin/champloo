module Champloo
  module NBT
    class ZlibNamedBinaryTag < NamedBinaryTag
      class << self
        def inflate(data)
          begin
            zstream = Zlib::Inflate.new(Zlib::MAX_WBITS)
            buf = zstream.inflate(data)
            zstream.finish
          ensure
            zstream.close
          end
          buf
        end

        def deflate(data)
          Zlib.deflate(data)
        end
      end

      def initialize(data)
        super(self.class.inflate(data))
      end

      def to_binary
        self.class.deflate(super)
      end
    end
  end
end
