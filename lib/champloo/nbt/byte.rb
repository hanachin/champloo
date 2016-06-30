module Champloo
  module NBT
    class Byte < Tag
      def tag_type
        Champloo::NBT::TAG_Byte
      end

      def to_binary
        [__getobj__].pack('c')
      end
    end
  end
end
