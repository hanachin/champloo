module Champloo
  module NBT
    class NamedBinaryTagEncoder
      class << self
        def encode(nbt)
          new(nbt).encode
        end
      end

      def initialize(nbt)
        @nbt = nbt
      end

      def encode
        @nbt.__getobj__.to_binary
      end
    end
  end
end
