class Authenticator
  SCOPES = 'https://www.googleapis.com/auth/userinfo.email'

  attr_accessor :token, :email
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def auth_url
    client.auth_code.authorize_url(redirect_uri: redirect_uri, scope: SCOPES, access_type: "offline")
  end

  def client
    client ||= OAuth2::Client.new(G_API_CLIENT, G_API_SECRET, {
                  :site => 'https://accounts.google.com',
                  :authorize_url => "/o/oauth2/auth",
                  :token_url => "/o/oauth2/token"
                })
  end

  def authenticate(code)
    access_token = client.auth_code.get_token(code, :redirect_uri => redirect_uri)
    @token = access_token.token
    @email = access_token.get('https://www.googleapis.com/userinfo/email?alt=json').parsed['data']['email'].downcase
  end

  private

  def redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/oauth2callback'
    uri.query = nil
    uri.to_s
  end
end
