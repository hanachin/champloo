module Champloo
  module NBT
    class Byte < SimpleDelegator
      def tag_type
        Champloo::NBT::TAG_Byte
      end
    end
  end
end
