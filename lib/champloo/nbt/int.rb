module Champloo
  module NBT
    class Int < SimpleDelegator
      def tag_type
        Champloo::NBT::TAG_Int
      end
    end
  end
end
