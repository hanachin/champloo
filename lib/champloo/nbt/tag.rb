require 'delegate'

module Champloo
  module NBT
    class Tag < SimpleDelegator
      def eql?(other)
        if Tag === other
          __getobj__.eql?(other.__getobj__)
        else
          __getobj__.eql?(other)
        end
      end
    end
  end
end
