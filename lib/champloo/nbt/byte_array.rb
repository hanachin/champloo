module Champloo
  module NBT
    class ByteArray < SimpleDelegator
      def tag_type
        Champloo::NBT::TAG_Byte_Array
      end

      def to_binary
        length = Champloo::NBT::Int.new(self.length)
        length.to_binary + map(&:to_binary).join
      end
    end
  end
end
