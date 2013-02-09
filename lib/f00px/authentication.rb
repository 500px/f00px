module F00px
  module Authentication

    def xauth(username, password)
      unless token? && token_secret?
        begin
          response = post('oauth/request_token')
          parse_oauth_response(response)

          params = { x_auth_mode: "client_auth", x_auth_username: username, x_auth_password: password}
          response = post("oauth/access_token", params)
          parse_oauth_response(response)
        rescue F00px::Error => e
          self.token = self.token_secret =  nil
          raise e
        end
      end
    end

    private
    def parse_oauth_response(response)
      unless response.status == 200
        raise F00px::Error.from_response(response)
      end

      hash = CGI.parse(response.body).inject({}) do |h, (k,v)|
        h[k.strip.to_sym] = v.first
        h
      end

      self.token = hash[:oauth_token]
      self.token_secret = hash[:oauth_token_secret]
    end

  end
end
