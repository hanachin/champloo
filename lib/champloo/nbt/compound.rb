module Champloo
  module NBT
    class Compound < Tag
      def tag_type
        Champloo::NBT::TAG_Compound
      end

      def [](key)
        if key.kind_of?(Integer)
          super(key)
        else
          detect {|named_tag| named_tag.name == key.to_s }
        end
      end

      def keys
        map(&:name)
      end

      def to_binary
        tag_end = Champloo::NBT::Byte.new(Champloo::NBT::TAG_End)
        map(&:to_binary).join + tag_end.to_binary
      end
    end
  end
end
