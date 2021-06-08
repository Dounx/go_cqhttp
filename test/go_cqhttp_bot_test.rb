# frozen_string_literal: true

require "test_helper"

class GoCQHTTPBotTest < Minitest::Test
  attr_reader :bot

  def setup
    @bot = GoCQHTTP::Bot.new(host: TEST_HOST, access_token: TEST_ACCESS_TOKEN)
  end

  def test_respond_to_missing
    assert_equal true, bot.respond_to?("get_group_info")
    assert_equal false, bot.respond_to?("foobar")
  end

  def test_method_missing_with_params
    response = bot.get_group_info(group_id: TEST_GROUP_ID)
    assert_equal 0, response["retcode"]
    assert_equal "ok", response["status"]

    response = bot.send_private_msg(user_id: TEST_USER_ID, message: "[Test] OK")
    assert_equal 0, response["retcode"]
    assert_equal "ok", response["status"]
  end

  def test_method_missing_without_params
    response = bot.get_login_info
    assert_equal 0, response["retcode"]
    assert_equal "ok", response["status"]
  end

  def test_endpoint
    assert_equal "get_group_info", bot.send(:endpoint, :get_group_info)
    assert_equal "admin/do_restart", bot.send(:endpoint, :admin_do_restart)
    assert_equal ".get_word_slices", bot.send(:endpoint, :hidden_get_word_slices)
    assert_equal "_get_vip_info", bot.send(:endpoint, :_get_vip_info)
  end
end
