# frozen_string_literal: true

require "test_helper"

class GoCQHTTPAPITest < Minitest::Test
  NOT_IN_LIST_URL = "foobar"
  IN_LIST_URL = "send_private_msg"

  def test_existed_return_false
    assert_equal false, GoCQHTTP::API.existed?(NOT_IN_LIST_URL)
  end

  def test_existed_return_true
    assert_equal true, GoCQHTTP::API.existed?(IN_LIST_URL)
  end

  def test_http_method_return_right
    GoCQHTTP::API.list.each do |endpoint|
      assert_includes %w[get post], GoCQHTTP::API.http_method(endpoint)
    end
  end

  def test_http_method_return_nil
    assert_nil GoCQHTTP::API.http_method(NOT_IN_LIST_URL)
  end
end
