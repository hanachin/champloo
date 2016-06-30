module Champloo
  module NBT
    class Short < SimpleDelegator
      def tag_type
        Champloo::NBT::TAG_Short
      end
    end
  end
end
