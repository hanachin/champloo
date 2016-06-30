module Champloo
  module NBT
    class Short < Tag
      def tag_type
        Champloo::NBT::TAG_Short
      end

      def to_binary
        [__getobj__].pack('s>')
      end
    end
  end
end
