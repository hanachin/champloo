require 'delegate'

module Champloo
  module NBT
    class NamedBinaryTag < SimpleDelegator
      class << self
        def read(file_path)
          new(File.binread(file_path))
        end
      end

      def initialize(data)
        super(NamedBinaryTagDecoder.decode(data))
      end

      def to_binary
        NamedBinaryTagEncoder.encode(self)
      end
    end
  end
end
