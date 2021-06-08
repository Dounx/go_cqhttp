# frozen_string_literal: true

require "cgi"

module GoCQHTTP
  # Classes for cq
  #
  # Event document: https://docs.go-cqhttp.org/cqcode
  # rubocop:disable Style/Documentation
  module CQ
    # Possible face id list: https://github.com/richardchien/coolq-http-api/wiki/%E8%A1%A8%E6%83%85-CQ-%E7%A0%81-ID-%E8%A1%A8
    class Face
      attr_accessor :id

      def initialize(id:)
        @id = id
      end

      def to_s
        "[CQ:face,id=#{id}]"
      end
    end

    # Send and Receive
    class Record
      attr_accessor :file, :url, :timeout, :magic, :cache, :proxy

      # rubocop:disable Metrics/ParameterLists
      def initialize(file:, url: nil, timeout: nil, magic: 0, cache: 1, proxy: 1)
        @file = file
        @url = url
        @timeout = timeout
        @magic = magic
        @cache = cache
        @proxy = proxy
        scheme = URI.parse(file).scheme
        @remote = %w[http https].include?(scheme)
      end

      def to_s
        params =
          if send?
            params = "file=#{file},magic=#{magic}"
            params += ",timeout=#{timeout}" if remote? && timeout
            params += ",cache=#{cache},proxy=#{proxy}" if remote?
            params
          else
            "file=#{file},url=#{url},magic=#{magic}"
          end
        "[CQ:record,#{params}]"
      end

      def remote?
        @remote
      end

      def send?
        !receive?
      end

      def receive?
        !!url
      end
    end

    # Only support HTTP
    class Video
      attr_accessor :file, :cover, :c

      # rubocop:disable Naming/MethodParameterName
      def initialize(file:, cover: nil, c: nil)
        @file = file
        @cover = cover
        @c = c
      end

      def to_s
        params = "file=#{file}"
        params += ",cover=#{cover}" if cover
        params += ",c=#{c}" if c
        "[CQ:video,#{params}]"
      end
    end

    class At
      attr_accessor :qq, :name

      def initialize(qq:, name: nil)
        @qq = qq
        @name = name
      end

      def to_s
        params = "qq=#{qq}"
        params += ",name=#{name}" if name
        "[CQ:at,#{params}]"
      end
    end

    # It has not been completed by Go-CQHTTP
    class RPS; end

    # It has not been completed by Go-CQHTTP
    class Dice; end

    # It has not been completed by Go-CQHTTP
    class Shake; end

    # It has not been completed by Go-CQHTTP
    class Anonymous; end

    class Share
      attr_accessor :url, :title, :content, :image

      def initialize(url:, title:, content: nil, image: nil)
        @url = url
        @title = title
        @content = content
        @image = image
      end

      def to_s
        params = "url=#{url},title=#{title}"
        params += ",content=#{content}" if content
        params += ",image=#{image}" if image
        "[CQ:share,#{params}]"
      end
    end

    # It has not been completed by Go-CQHTTP
    class Contact; end

    # It has not been completed by Go-CQHTTP
    class Location; end

    class Music
      attr_accessor :type, :id, :url, :audio, :title, :content, :image

      def initialize(type:, id: nil, url: nil, audio: nil, title: nil, content: nil, image: nil)
        @type = type
        @id = id
        @url = url
        @audio = audio
        @title = title
        @content = content
        @image = image
      end

      def to_s
        params =
          if custom?
            params = "type=#{type},url=#{url},audio=#{audio},title=#{title}"
            params += ",content=#{content}" if content
            params += ",image=#{image}" if image
            params
          else
            "type=#{type},id=#{id}"
          end

        "[CQ:music,#{params}]"
      end

      def custom?
        type == "custom"
      end
    end

    class Image
      attr_accessor :file, :type, :url, :cache, :id, :c

      # rubocop:disable Style/NumericLiterals
      def initialize(file:, type: nil, url: nil, cache: 1, id: 40000, c: nil)
        @file = file
        @type = type
        @url = url
        @cache = cache
        @id = id
        @c = c
      end

      def to_s
        params = "file=#{file},type=#{type},url=#{url},cache=#{cache},id=#{id}"
        params += ",c=#{c}" if c
        "[CQ:image,#{params}]"
      end
    end

    class Reply
      attr_accessor :id, :text, :qq, :time, :seq

      def initialize(id: nil, text: nil, qq: nil, time: nil, seq: nil)
        @id = id
        @text = text
        @qq = qq
        @time = time
        @seq = seq
      end

      def to_s
        params =
          if custom?
            "text=#{text},qq=#{qq},time=#{time},seq=#{seq}"
          else
            "id=#{id}"
          end
        "[CQ:reply,#{params}]"
      end

      def custom?
        !!qq
      end
    end

    class RedBag
      attr_accessor :title

      def initialize(title:)
        @title = title
      end

      def to_s
        "[CQ:redbag,title=#{title}]"
      end
    end

    class Poke
      attr_accessor :qq

      def initialize(qq:)
        @qq = qq
      end

      def to_s
        "[CQ:poke,qq=#{qq}]"
      end
    end

    class Gift
      attr_accessor :qq, :id

      def initialize(qq:, id:)
        @qq = qq
        @id = id
      end

      def to_s
        "[CQ:gift,qq=#{qq},id=#{id}]"
      end
    end

    class Forward
      attr_accessor :id

      def initialize(id:)
        @id = id
      end

      def to_s
        "[CQ:forward,id=#{id}]"
      end
    end

    class Node
      attr_accessor :id, :name, :uin, :content, :seq

      def initialize(id:, name:, uin:, content:, seq:)
        @id = id
        @name = name
        @uin = uin
        @content = content
        @seq = seq
      end

      # rubocop:disable Metrics/MethodLength
      def to_h
        data_params =
          if custom?
            {
              name: name,
              uin: uin,
              content: content
            }
          else
            {
              id: id
            }
          end
        data_params.merge!(seq: seq) if custom? && seq

        { type: "node", data: data_params }
      end

      def to_s
        to_h.to_json
      end

      def custom?
        !!name
      end
    end

    class XML
      attr_accessor :data, :resid

      def initialize(data:, resid: nil)
        @data = CGI.escapeHTML(data)
        @resid = resid
      end

      def to_s
        params = "data=#{data}"
        params += ",resid=#{resid}"
        "[CQ:xml,#{params}]"
      end
    end

    class JSON
      attr_accessor :data, :resid

      def initialize(data:, resid: nil)
        @data = escape(data)
        @resid = resid
      end

      def to_s
        params = "data=#{data}"
        params += ",resid=#{resid}"
        "[CQ:json,#{params}]"
      end

      def escape(data)
        data = CGI.escapeHTML(data)
        data.gsub(",", "&#44;")
            .gsub("&", "&amp;")
            .gsub("[", "&#91;")
            .gsub("]", "&#93;")
      end
    end

    class CardImage
      attr_accessor :file, :minwidth, :minheight, :maxwidth, :maxheight, :source, :icon

      def initialize(file:, minwidth: nil, minheight: nil, maxwidth: nil, maxheight: nil, source: nil, icon: nil)
        @file = file
        @minwidth = minwidth
        @minheight = minheight
        @maxwidth = maxwidth
        @maxheight = maxheight
        @source = source
        @icon = icon
      end

      def to_s
        params = "file=#{file}"
        params += ",minwidth=#{minwidth}" if minwidth
        params += ",minheight=#{minheight}" if minheight
        params += ",maxwidth=#{maxwidth}" if maxwidth
        params += ",maxheight=#{maxheight}" if maxheight
        params += ",source=#{source}" if source
        params += ",icon=#{icon}" if icon
        "[CQ:cardimage,#{params}]"
      end
    end

    class TTS
      attr_accessor :text

      def initialize(text:)
        @text = text
      end

      def to_s
        "[CQ:tts,text=#{text}]"
      end
    end
  end
end
