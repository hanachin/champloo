module Champloo
  module NBT
    class IntArray < SimpleDelegator
      def tag_type
        Champloo::NBT::TAG_Int_Array
      end
    end
  end
end
