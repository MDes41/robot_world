require_relative '../test_helper'

class RootDirectoryHasContent < FeatureTest
  def test_root_directory_has_create_new
    visit '/'
    assert page.has_content?("Robot Inventory")
    assert page.has_content?("New Robot")
    assert page.has_content?("Robots Summary")
  end
end
