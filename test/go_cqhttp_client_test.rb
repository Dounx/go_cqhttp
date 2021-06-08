# frozen_string_literal: true

require "test_helper"

class GoCQHTTPClientTest < Minitest::Test
  attr_reader :client

  def setup
    @client = GoCQHTTP::Client.new(host: TEST_HOST, access_token: TEST_ACCESS_TOKEN)
  end

  def test_get_with_params_ok
    response = client.get("get_group_info", group_id: TEST_GROUP_ID)
    assert_equal 0, response["retcode"]
    assert_equal "ok", response["status"]
  end

  def test_get_without_params_ok
    response = client.get("get_login_info")
    assert_equal 0, response["retcode"]
    assert_equal "ok", response["status"]
  end

  def test_get_100_fail
    response = client.get("get_group_info")
    assert_equal 100, response["retcode"]
    assert_equal "failed", response["status"]
  end

  def test_get_404_fail
    response = client.get("foobar")
    assert_equal 404, response["retcode"]
    assert_equal "failed", response["status"]
  end

  def test_post_with_params_ok
    response = client.post("send_private_msg", user_id: TEST_USER_ID, message: "[Test] OK")
    assert_equal 0, response["retcode"]
    assert_equal "ok", response["status"]
  end

  def test_post_100_fail
    response = client.post("send_private_msg")
    assert_equal 100, response["retcode"]
    assert_equal "failed", response["status"]
  end

  def test_post_404_fail
    response = client.post("foobar")
    assert_equal 404, response["retcode"]
    assert_equal "failed", response["status"]
  end
end
