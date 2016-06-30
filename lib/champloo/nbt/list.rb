module Champloo
  module NBT
    class List < Tag
      def initialize(item_tag_type, list)
        super(list)
        @item_tag_type = item_tag_type
      end

      def tag_type
        Champloo::NBT::TAG_List
      end

      def to_binary
        item_tag_type = Champloo::NBT::Byte.new(@item_tag_type)
        length = Champloo::NBT::Int.new(self.length)
        item_tag_type.to_binary + length.to_binary + map(&:to_binary).join
      end
    end
  end
end
