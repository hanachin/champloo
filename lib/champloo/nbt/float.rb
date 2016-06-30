module Champloo
  module NBT
    class Float < SimpleDelegator
      def tag_type
        Champloo::NBT::TAG_Float
      end
    end
  end
end
