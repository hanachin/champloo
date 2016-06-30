module Champloo
  module NBT
    class Compound < Tag
      def tag_type
        Champloo::NBT::TAG_Compound
      end

      def to_binary
        tag_end = Champloo::NBT::Byte.new(Champloo::NBT::TAG_End)
        map(&:to_binary).join + tag_end.to_binary
      end
    end
  end
end
