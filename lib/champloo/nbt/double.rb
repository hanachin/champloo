module Champloo
  module NBT
    class Double < Tag
      def tag_type
        Champloo::NBT::TAG_Double
      end

      def to_binary
        [__getobj__].pack('G')
      end
    end
  end
end
