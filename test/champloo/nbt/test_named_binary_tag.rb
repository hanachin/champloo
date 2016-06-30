require 'test_helper'

class Champloo::NBT::NamedBinaryTagTest < Minitest::Test
  def setup
    @nbt_content = File.binread('level.dat.uncompressed')
    @nbt = Champloo::NBT::NamedBinaryTag.new(@nbt_content)
  end

  def test_to_binary
    assert { @nbt.to_binary == @nbt_content }
  end
end
