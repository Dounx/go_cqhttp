# frozen_string_literal: true

require "test_helper"

class GoCQHTTPCQTest < Minitest::Test
  attr_reader :bot

  def setup
    @bot = GoCQHTTP::Bot.new(host: TEST_HOST, access_token: TEST_ACCESS_TOKEN)
  end

  def test_face
    face = GoCQHTTP::CQ::Face.new(id: 1)
    response = send_message(face)
    assert_ok(response)
  end

  def test_send_record
    record_path = "https://raw.staticdn.net/Dounx/go_cqhttp/main/test/assets/record.mp3"
    record = GoCQHTTP::CQ::Record.new(file: record_path)
    response = send_message(record)
    assert_ok(response)
  end

  def test_video
    video_path = "http://raw.staticdn.net/Dounx/go_cqhttp/main/test/assets/video.mp4"
    video = GoCQHTTP::CQ::Video.new(file: video_path)
    response = send_message(video)
    assert_ok(response)
  end

  def test_at
    at = GoCQHTTP::CQ::At.new(qq: TEST_USER_ID)
    response = send_group_message(at)
    assert_ok(response)
  end

  def test_share
    url = "https://github.com/dounx"
    share = GoCQHTTP::CQ::Share.new(url: url, title: "GitHub")
    response = send_message(share)
    assert_ok(response)
  end

  def test_music
    id = "1343016814"
    music = GoCQHTTP::CQ::Music.new(type: "163", id: id)
    response = send_message(music)
    assert_ok(response)
  end

  def test_image
    image_path = "https://raw.staticdn.net/Dounx/go_cqhttp/main/test/assets/image.png"
    image = GoCQHTTP::CQ::Image.new(file: image_path)
    response = send_message(image)
    assert_ok(response)
  end

  def test_reply
    response = send_message("[Test] OK")
    assert_ok(response)
    id = response["data"]["message_id"]
    reply = GoCQHTTP::CQ::Reply.new(id: id)
    response = send_message(reply, "[Test] OK")
    assert_ok(response)
  end

  def test_poke
    poke = GoCQHTTP::CQ::Poke.new(qq: TEST_USER_ID)
    response = send_group_message(poke)
    assert_ok(response)
  end

  def test_gift
    gift = GoCQHTTP::CQ::Gift.new(id: 0, qq: TEST_USER_ID)
    response = send_group_message(gift)
    assert_ok(response)
  end

  def test_tts
    tts = GoCQHTTP::CQ::TTS.new(text: "Can you hear me?")
    response = send_group_message(tts)
    assert_ok(response)
  end

  private

  def send_message(*messages)
    messages = messages.map(&:to_s).join(" ")
    bot.send_private_msg(user_id: TEST_USER_ID, message: messages)
  end

  def send_group_message(*messages)
    messages = messages.map(&:to_s).join(" ")
    bot.send_group_msg(group_id: TEST_GROUP_ID, message: messages)
  end

  def assert_ok(response)
    assert_equal 0, response["retcode"]
    assert_equal "ok", response["status"]
  end
end
