require 'test_helper'

class Champloo::AnvilTest < Minitest::Test
  def setup
    @anvil_content = File.binread('r.0.0.mca')
    @anvil = Champloo::Anvil.new(@anvil_content)
  end

  def test_to_binary
    assert @anvil.to_binary == @anvil_content
  end
end
