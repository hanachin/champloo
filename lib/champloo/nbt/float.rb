module Champloo
  module NBT
    class Float < Tag
      def tag_type
        Champloo::NBT::TAG_Float
      end

      def to_binary
        [__getobj__].pack('g')
      end
    end
  end
end
