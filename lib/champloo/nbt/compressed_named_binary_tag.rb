require 'zlib'

module Champloo
  module NBT
    class CompressedNamedBinaryTag < NamedBinaryTag
      class << self
        def inflate(data)
          begin
            zstream = Zlib::Inflate.new(Zlib::MAX_WBITS | 32)
            buf = zstream.inflate(data)
            zstream.finish
          ensure
            zstream.close
          end
          buf
        end
      end

      def initialize(data)
        super(self.class.inflate(data))
      end
    end
  end
end
