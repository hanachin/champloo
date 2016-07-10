module Champloo
  module Anvil
    class Location
      def initialize(l)
        @l = l
      end

      def offset
        @l >> 8
      end

      def sector_count
        @l & 0xFF
      end

      def to_i
        @l
      end
    end
  end
end
