module Champloo
  module NBT
    class String < SimpleDelegator
      def tag_type
        Champloo::NBT::TAG_String
      end
    end
  end
end
