module Champloo
  module NBT
    class NamedBinaryTagEncoder
      class << self
        def encode(nbt)
          new(nbt.data).encode
        end
      end

      def initialize(data)
        @data = data
      end

      def encode
        @data.to_binary
      end
    end
  end
end
