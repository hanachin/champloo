module Champloo
  module NBT
    class IntArray < Tag
      def tag_type
        Champloo::NBT::TAG_Int_Array
      end

      def to_binary
        length = Champloo::NBT::Int.new(self.length)
        length + map(&:to_binary).join
      end
    end
  end
end
