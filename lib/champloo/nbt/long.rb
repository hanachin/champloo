module Champloo
  module NBT
    class Long < SimpleDelegator
      def tag_type
        Champloo::NBT::TAG_Long
      end
    end
  end
end
