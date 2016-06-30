module Champloo
  module NBT
    class NamedTag < Tag
      attr_accessor :name

      def initialize(name, tag)
        super(tag)

        @name = name
      end

      def eql?(other)
        super && name == other.name
      end

      def to_binary
        tag_type = Champloo::NBT::Byte.new(self.tag_type)
        name = Champloo::NBT::String.new(@name)
        tag_type.to_binary + name.to_binary + super
      end
    end
  end
end
