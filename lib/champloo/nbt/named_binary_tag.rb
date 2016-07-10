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
        super(Champloo::NBT::Decoder.decode(data))
      end

      def to_binary
        Champloo::NBT::Encoder.encode(self)
      end
    end
  end
end
