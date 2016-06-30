module Champloo
  module NBT
    class Compound < SimpleDelegator
      def tag_type
        Champloo::NBT::TAG_Compound
      end
    end
  end
end
