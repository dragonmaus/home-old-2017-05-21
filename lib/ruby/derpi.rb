require "canon"
require "json"

module Addressable
  class URI
    def fixup
      uri = self.normalize

      # Derpibooru
      if uri.is_derpi?
        match = uri.path.match(/\A\/(?:images\/)?(\d+)/)
        return Addressable::URI.parse("https://derpibooru.org/#{match[1]}") if match
        uri.hostname = "derpibooru.org"
      elsif uri.host.end_with?("derpicdn.net") and not uri.path.start_with?("/avatars/")
        return Addressable::URI.parse(Addressable::URI.form_unencode(uri.query).to_h["url"]).fixup if uri.host == "camo.derpicdn.net"
        match = uri.path.match(/\A.*\/(\d+)/)
        return Addressable::URI.parse("https://derpibooru.org/#{match[1]}") if match

      # desustorage
      elsif uri.host.end_with?("desustorage.org")
        uri.scheme = "http" if uri.scheme == "https"

      # deviantArt
      elsif uri.host.end_with?("deviantart.com")
        return Addressable::URI.parse(uri.query).fixup if uri.path == "/users/outgoing" and uri.query
        if uri.fragment
          match = uri.fragment.match(/\/(d\w{6})/)
          return Addressable::URI.parse("http://fav.me/#{match[1]}") if match
        end
      elsif uri.host.end_with?("deviantart.net")
        match = uri.path.split(?/)[-1].match(/\A.*\b(d\w{6})/)
        return Addressable::URI.parse("http://fav.me/#{match[1]}") if match

      # e621
      elsif uri.host.end_with?("e621.net")
        if uri.host.start_with?("static")
          match = uri.path.match(/\A\/data\/..\/..\/(\h{32})/)
          if match
            json = Addressable::URI.parse("https://e621.net/post/show.json?md5=#{match[1]}").fetch.body
            return Addressable::URI.parse("https://e621.net/post/show/#{JSON.parse(json)["id"]}") if json.length > 0
          end
        else
          match = uri.path.match(/\A\/post\/show\/(\d+)/)
          return Addressable::URI.parse("https://e621.net/post/show/#{match[1]}") if match
        end

      # Imgur
      elsif uri.host == "i.imgur.com"
        return Addressable::URI.parse("http://imgur.com/#{uri.path.split(?/)[-1].split(?.)[0]}")

      # Inkbunny
      elsif uri.host.end_with?("inkbunny.net")
        uri.fragment = nil if uri.fragment == "pictop"

      # Know Your Meme
      elsif uri.host.end_with?("kym-cdn.com")
        return Addressable::URI.parse("http://knowyourmeme.com/photos/#{uri.path.split(?/)[-4,3].join("")}")

      # My Little Face When
      elsif uri.host.end_with?("mylittlefacewhen.com")
        match = uri.path.match(/\A\/media\/.*\/mlfw(\d+)/)
        return Addressable::URI.parse("http://mylittlefacewhen.com/f/#{match[1]}") if match

      # Pixiv
      elsif uri.host.end_with?("pixiv.net")
        uri.scheme = "http" if uri.scheme == "https"

      # Rule 34
      elsif uri.host.end_with?("rule34.paheal.net")
        uri.scheme = "http" if uri.scheme == "https"

      # Tumblr
      elsif uri.is_tumblr?
        uri.fragment = nil if uri.fragment == "_=_"
        if uri.path == "/login" and uri.query and uri.query_values["redirect_to"]
          uri.path = uri.query_values["redirect_to"]
          uri.query = nil
        end
        if uri.path.start_with?("/blog/")
          return Addressable::URI.parse("#{uri.scheme}://#{uri.path.split(?/)[2]}.tumblr.com/").fixup
        end
        match = uri.path.match(/\A\/\w+\/(\d+)/) unless uri.path.start_with?("/post/")
        return Addressable::URI.parse("http://#{uri.host}/post/#{match[1]}") if match
      elsif uri.host == "t.umblr.com"
        return Addressable::URI.parse(Addressable::URI.form_unencode(uri.query).to_h["z"]).fixup

      end

      uri
    end

    def is_derpi?
      self.host.end_with?("derpibooru.org") ||
        self.host.end_with?("derpiboo.ru") ||
        self.host.end_with?("trixiebooru.org")
    end

    def is_tumblr?
      self.host.end_with?("tumblr.com") ||
        self.host.end_with?("jayisbutts.com") ||
        self.host.end_with?("jykinturah.me") ||
        self.host.end_with?("kevinsano.com") ||
        self.host.end_with?("mangochan.com") ||
        self.host.end_with?("sugaryviolet.horse")
    end
  end
end

module Derpi
  extend self

  def link(name)
    "\"@#{name}@\":/tags/#{self.slug(name)}"
  end

  def slug(name)
    name = name.downcase

    name.gsub!(?-, "-dash-")
    name.gsub!(?/, "-fwslash-")
    name.gsub!(?\\, "-bwslash-")
    name.gsub!(?:, "-colon-")
    name.gsub!(?., "-dot-")
    name.gsub!(?+, "-plus-")

    Addressable::URI.escape(name).gsub("%20", ?+)
  end
end
