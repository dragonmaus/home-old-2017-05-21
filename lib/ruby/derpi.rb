require 'canon'
require 'json'

module Addressable
  class URI
    def fixup!
      normalize!

      # Derpibooru
      if derpi?
        return replace_self(Addressable::URI.parse("https://derpibooru.org/#{id}")) if /\A\/(?:images\/)?(?<id>\d+)/ =~ @path
        @host = 'derpibooru.org'
      elsif @host == 'camo.derpicdn.net'
        return replace_self(Addressable::URI.parse(Addressable::URI.form_unencode(@query).to_h['url']).fixup!)
      elsif @host.end_with?('derpicdn.net') && !@path.start_with?('/avatars/')
        return replace_self(Addressable::URI.parse("https://derpibooru.org/#{id}")) if /\A.*\/(?<id>\d+)/ =~ @path

      # desustorage
      elsif @host.end_with?('desustorage.org')
        @scheme = 'http' if @scheme == 'https'

      # DeviantArt
      elsif @host.end_with?('deviantart.com')
        return replace_self(Addressable::URI.parse(@query).fixup!) if @path == '/users/outgoing' && @query
        return replace_self(Addressable::URI.parse("http://fav.me/#{id}")) if @fragment && /\/(?<id>d\w{6})/ =~ @fragment
      elsif @host.end_with?('deviantart.net')
        return replace_self(Addressable::URI.parse("http://fav.me/#{id}")) if /\A.*\b(?<id>d\w{6})\b/ =~ @path.split('/').last

      # e621
      elsif @host.end_with?('e621.net')
        if @host.start_with?('static') && /\A\/data\/..\/..\/(?<hash>\h{32})/ =~ @path
          json = Addressable::URI.parse("https://e621.net/post/show.json?md5=#{hash}").fetch.body
          return replace_self(Addressable::URI.parse("https://e621.net/post/show/#{JSON.parse(json)['id']}")) unless json.empty?
        end
        return replace_self(Addressable::URI.parse("https://e621.net/post/show/#{id}")) if /\A\/post\/show\/(?<id>\d+)/ =~ @path

      # Imgur
      elsif @host == 'i.imgur.com'
        return replace_self(Addressable::URI.parse("http://imgur.com/#{@path.split('/').last.split('.').first}"))

      # Inkbunny
      elsif @host.end_with?('inkbunny.net')
        @fragment = nil if @fragment == 'pictop'

      # Know Your Meme
      elsif @host.end_with?('kym-cdn.com')
        return replace_self(Addressable::URI.parse("http://knowyourmeme.com/photos/#{@path.split('/')[-4, 3].join('')}"))

      # My Little Face When
      elsif @host.end_with?('mylittlefacewhen.com')
        return replace_self(Addressable::URI.parse("http://mylittlefacewhen.com/f/#{id}")) if /\A\/media\/.*\/mlfw(?<id>\d+)/ =~ @path

      # Pixiv
      elsif @host.end_with?('pixiv.net')
        @scheme = 'http' if @scheme == 'https'

      # Rule 34
      elsif @host.end_with?('rule34.paheal.net')
        @scheme = 'http' if @scheme == 'https'

      # Tumblr
      elsif tumblr?
        @fragment = nil if @fragment == '_=_'
        if @path == '/login' && @query && query_values['redirect_to']
          @path = query_values['redirect_to']
          @query = nil
        end
        return replace_self(Addressable::URI.parse("#{@scheme}://#{@path.split('/')[2]}.tumblr.com/").fixup!) if @path.start_with?('/blog/')
        return replace_self(Addressable::URI.parse("http://#{@host}/post/#{id}")) if !@path.start_with?('/post/') && /\A\/\w+\/(?<id>\d+)/ =~ @path
      elsif @host == 't.umblr.com'
        return replace_self(Addressable::URI.parse(Addressable::URI.form_unencode(@query).to_h['z']).fixup!)

      end

      self
    end

    private

    def derpi?
      @host.end_with?('derpibooru.org',
                      'derpiboo.ru',
                      'trixiebooru.org')
    end

    def tumblr?
      @host.end_with?('tumblr.com',
                      'fruitymilk.co.uk',
                      'jayisbutts.com',
                      'jykinturah.me',
                      'kevinsano.com',
                      'mangochan.com',
                      'sugaryviolet.horse')
    end
  end
end

module Derpi
  module_function

  def link(name)
    "\"@#{name}@\":/tags/#{slug(name)}"
  end

  def slug(name)
    name = name.downcase

    name.gsub!('-', '-dash-')
    name.gsub!('/', '-fwslash-')
    name.gsub!('\\', '-bwslash-')
    name.gsub!(':', '-colon-')
    name.gsub!('.', '-dot-')
    name.gsub!('+', '-plus-')

    Addressable::URI.escape(name).gsub('%20', '+')
  end
end
