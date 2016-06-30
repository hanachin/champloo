require 'test_helper'

class Champloo::NBT::CompressedNamedBinaryTagTest < Minitest::Test
  def setup
    @nbt_content = File.binread('level.dat')
    @nbt = Champloo::NBT::CompressedNamedBinaryTag.new(@nbt_content)
  end

  def test_to_binary
    assert { @nbt.to_binary == @nbt_content }
  end
end
