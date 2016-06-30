module Champloo
  module NBT
    class Long < Tag
      def tag_type
        Champloo::NBT::TAG_Long
      end

      def to_binary
        [__getobj__].pack('q>')
      end
    end
  end
end
