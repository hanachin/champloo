module Champloo
  module NBT
    class List < SimpleDelegator
      def tag_type
        Champloo::NBT::TAG_List
      end
    end
  end
end
