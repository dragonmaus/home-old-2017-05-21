# frozen_string_literal: true
require 'addressable/uri'
require 'hpricot'
require 'net/http'

module Addressable
  class URI
    def canonical
      dup.canonical!
    end

    def canonical!
      fixup!

      response = fetch
      response.uri ||= dup
      response.uri.normalize!

      unless response.is_a? Net::HTTPOK
        warn "#{response.uri} returned status code #{response.code}"
        return replace_self response.uri
      end

      return replace_self response.uri unless response.content_type == 'text/html'

      document = Hpricot.parse response.body
      # <link rel="canonical"> takes priority over <meta property="og:url">
      replace_self(
        if (element = document.at 'link[@rel="canonical"]')
          self.class.parse element['href']
        elsif (element = document.search('meta[@property$="url"]') \
                                 .select { |e| e['property'] == 'og:url' } \
                                 .first)
          self.class.parse element['content']
        else
          response.uri
        end
      )

      # The spec allows the canonical link to be a relative URI
      replace_self self.class.join response.uri.to_s, self unless absolute?

      # Because you can't always trust sites to do things properly
      normalize!
    end

    def fetch(limit = 50)
      Net::HTTP.start hostname, port, use_ssl: scheme == 'https' do |http|
        response, uri = follow http, self, limit, :head

        if !response.is_a?(Net::HTTPOK) || text?(response.content_type)
          # Some (rude) sites don't allow HEAD requests
          response, uri = follow http, uri, (limit / 10).to_i, :get
        end

        response.uri ||= uri
        response
      end
    end

    def fixup
      dup.fixup!
    end

    def fixup!
      normalize!
    end

    private

    def text?(type)
      type.start_with?('text/') || type == 'application/json'
    end

    def follow(http, uri, limit, method)
      uri = uri.dup

      limit.times do
        request = case method
                  when :get
                    Net::HTTP::Get.new uri
                  when :head
                    Net::HTTP::Head.new uri
                  end
        request['user-agent'] = 'Mozilla/5.0'

        response = http.request request

        return response, uri unless response.is_a? Net::HTTPRedirection

        previous_uri = uri
        uri = self.class.join uri.to_s, response['location']
        uri.fixup!

        # Detect redirect loops early
        return response, uri if uri == previous_uri
      end
    end
  end
end
