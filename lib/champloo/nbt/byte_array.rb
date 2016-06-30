module Champloo
  module NBT
    class ByteArray < SimpleDelegator
      def tag_type
        Champloo::NBT::TAG_Byte_Array
      end
    end
  end
end
