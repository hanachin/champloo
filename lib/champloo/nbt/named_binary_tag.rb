module Champloo
  module NBT
    class NamedBinaryTag
      attr_reader :data

      class << self
        def read(file_path)
          new(File.binread(file_path))
        end
      end

      def initialize(data)
        @data = NamedBinaryTagDecoder.decode(data)
      end
    end
  end
end
