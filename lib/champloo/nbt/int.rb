module Champloo
  module NBT
    class Int < Tag
      def tag_type
        Champloo::NBT::TAG_Int
      end

      def to_binary
        [__getobj__].pack('i>')
      end
    end
  end
end
