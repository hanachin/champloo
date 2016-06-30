module Champloo
  module NBT
    class NamedBinaryTagDecoder
      class DecodeError < StandardError; end

      class << self
        def decode(data)
          new(data.dup).decode
        end
      end

      def initialize(data)
        @data = data
      end

      def decode
        i, decoded_data = decode_named_tag(0)

        unless i == @data.size
          raise DecodeError
        end

        decoded_data
      end

      private

      def decode_byte(i)
        return i + 1, Champloo::NBT::Byte.new(*@data[i].unpack('c'))
      end

      def decode_short(i)
        return i + 2, Champloo::NBT::Short.new(*@data[i, 2].unpack('s>'))
      end

      def decode_int(i)
        return i + 4, Champloo::NBT::Int.new(*@data[i, 4].unpack('i>'))
      end

      def decode_long(i)
        return i + 8, Champloo::NBT::Long.new(*@data[i, 8].unpack('q>'))
      end

      def decode_float(i)
        return i + 4, Champloo::NBT::Float.new(*@data[i, 4].unpack('g'))
      end

      def decode_double(i)
        return i + 8, Champloo::NBT::Double.new(*@data[i, 8].unpack('G'))
      end

      def decode_byte_array(i)
        i, len = decode_int(i)
        bytes = []
        len.times do |offset|
          _, byte = decode_byte(i + offset)
          bytes << byte
        end
        return i + len, Champloo::NBT::ByteArray.new(bytes)
      end

      def decode_string(i)
        i, len = decode_short(i)
        return i + len, Champloo::NBT::String.new(@data[i, len].force_encoding(Encoding::UTF_8))
      end

      def decode_list(i)
        i, tag_type = decode_byte(i)
        i, len = decode_int(i)

        decode_method_name = decode_method_name_for(tag_type)
        list = []
        len.times do
          i, item = send(decode_method_name, i)
          list << item
        end
        return i, Champloo::NBT::List.new(list)
      end

      def decode_compound(i)
        decoded_data = {}

        while i < @data.size
          i, named_tag = decode_named_tag(i)

          break unless named_tag

          decoded_data[named_tag.name] = named_tag
        end

        return i, Champloo::NBT::Compound.new(decoded_data)
      end

      def decode_int_array(i)
        i, len = decode_int(i)
        ns = []
        len.times do
          i, n = decode_int(i)
          ns << n
        end
        return i, Champloo::NBT::IntArray.new(ns)
      end

      def decode_named_tag(i)
        i, tag_type = decode_byte(i)

        unless decode_method_name = decode_method_name_for(tag_type)
          return i, false
        end

        i, name = decode_string(i)
        i, decoded_data = send(decode_method_name, i)
        return i, Champloo::NBT::NamedTag.new(name, decoded_data)
      end

      def decode_method_name_for(tag_type)
        case tag_type
        when TAG_End
          false
        when TAG_Byte
          :decode_byte
        when TAG_Short
          :decode_short
        when TAG_Int
          :decode_int
        when TAG_Long
          :decode_long
        when TAG_Float
          :decode_float
        when TAG_Double
          :decode_double
        when TAG_Byte_Array
          :decode_byte_array
        when TAG_String
          :decode_string
        when TAG_List
          :decode_list
        when TAG_Compound
          :decode_compound
        when TAG_Int_Array
          :decode_int_array
        end
      end
    end
  end
end
