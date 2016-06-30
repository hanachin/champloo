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
    end
  end
end
