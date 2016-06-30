module Champloo
  module NBT
    class String < Tag
      def tag_type
        Champloo::NBT::TAG_String
      end

      def to_binary
        length = Champloo::NBT::Short.new(self.bytesize)
        length.to_binary + self.dup.force_encoding(Encoding::BINARY)
      end
    end
  end
end
