require 'test_helper'

class Champloo::RegionTest < Minitest::Test
  def setup
    @region_content = File.binread('r.0.0.mca')
    @region = Champloo::Region.new(@region_content)
  end

  def test_to_binary
    assert @region.to_binary == @region_content
  end
end
