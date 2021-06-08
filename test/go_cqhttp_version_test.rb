# frozen_string_literal: true

require "test_helper"

class GoCQHTTPTest < Minitest::Test
  def test_has_a_version_number
    refute_nil ::GoCQHTTP::VERSION
  end
end
