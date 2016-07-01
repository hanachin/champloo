require 'zlib'
require 'stringio'

module Champloo
  module NBT
    class GzippedNamedBinaryTag < NamedBinaryTag
      class << self
        def inflate(data)
          StringIO.open(data) do |input|
            Zlib::GzipReader.wrap(input) do |gz|
              gz.read.force_encoding(Encoding::BINARY)
            end
          end
        end

        def deflate(data)
          StringIO.open(''.force_encoding(Encoding::BINARY)) do |out|
            Zlib::GzipWriter.wrap(out) {|gz| gz.write(data) }
            out.string.tap {|s| s[4, 6] = 0.chr * 6 }
          end
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
