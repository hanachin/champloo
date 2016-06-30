require 'champloo/nbt/tag'

# NBT Tag Types
require 'champloo/nbt/byte'
require 'champloo/nbt/short'
require 'champloo/nbt/int'
require 'champloo/nbt/long'
require 'champloo/nbt/float'
require 'champloo/nbt/double'
require 'champloo/nbt/byte_array'
require 'champloo/nbt/string'
require 'champloo/nbt/list'
require 'champloo/nbt/compound'
require 'champloo/nbt/int_array'

require 'champloo/nbt/named_binary_tag'
require 'champloo/nbt/named_binary_tag_decoder'
require 'champloo/nbt/named_binary_tag_encoder'
require 'champloo/nbt/compressed_named_binary_tag'

module Champloo
  module NBT
    TAG_End        = 0
    TAG_Byte       = 1
    TAG_Short      = 2
    TAG_Int        = 3
    TAG_Long       = 4
    TAG_Float      = 5
    TAG_Double     = 6
    TAG_Byte_Array = 7
    TAG_String     = 8
    TAG_List       = 9
    TAG_Compound   = 10
    TAG_Int_Array  = 11
  end
end
