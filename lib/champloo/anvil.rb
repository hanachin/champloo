require 'champloo/anvil/decoder'
require 'champloo/anvil/encoder'

module Champloo
  module Anvil
    COMPRESSION_TYPE_GZIP = 1
    COMPRESSION_TYPE_ZLIB = 2

    MAX_CHUNK_NUM   = 1024
    LOCATIONS_SIZE  = MAX_CHUNK_NUM * 4
    TIMESTAMPS_SIZE = MAX_CHUNK_NUM * 4
    SECTOR_SIZE     = 1024 * 4
  end
end
