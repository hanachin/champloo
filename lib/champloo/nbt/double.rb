module Champloo
  module NBT
    class Double < SimpleDelegator
      def tag_type
        Champloo::NBT::TAG_Double
      end
    end
  end
end
