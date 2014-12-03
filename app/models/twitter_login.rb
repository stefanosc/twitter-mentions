require 'net/http'
require 'simple_oauth'

class TwitterLogin

  def initialize(credentials={})
    @credentials = credentials
    @credentials.merge!({consumer_key: ENV["T_CONSUMER_KEY"],
                        consumer_secret: ENV["T_CONSUMER_SECRET"]})
  end

  def request_oauth_token
    url = "https://api.twitter.com/oauth/request_token"
    @credentials.delete(:consumer_secret)
    @credentials.merge!(callback: URI.parse("http://localhost/hello").to_s)
    send_request(url, "Post")
  end

  def send_request(url, method, form_data={})
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    method = method.titleize
    request = Object.const_get("Net::HTTP::#{method}").new(uri)
    request.set_form_data(form_data)
    require 'pry'; binding.pry
    request["Authorization"] = oauth_header(request)
    response = http.request(request)

    return response
  end

  private

  def oauth_header(request)
    SimpleOAuth::Header.new(request.method, request.uri, URI.decode_www_form(request.body.to_s), @credentials).to_s
  end

end
