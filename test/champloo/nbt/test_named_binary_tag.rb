require 'test_helper'

class Champloo::NBT::NamedBinaryTagTest < Minitest::Test
  def setup
    @nbt = Champloo::NBT::NamedBinaryTag.read('level.dat')
  end

  def test_to_binary
    assert { Champloo::NBT::NamedBinaryTag.new(@nbt.to_binary).data == @nbt.data }
  end
end
