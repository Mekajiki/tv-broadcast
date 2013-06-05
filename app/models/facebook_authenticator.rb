class FacebookAuthenticator
  def initialize(auth)
    @auth = auth
  end

  def create_or_update_user
    user = User.where(uid: uid).first || User.new(status: :pending)
    user.update_attributes(uid: uid, name: name, token: token)
    user
  end

  private
    def uid
      @uid ||= @auth.uid
    end

    def info
      @info ||= @auth.info
    end

    def credentials
      @credentials ||= @auth.credentials
    end

    def name
      @name ||= info.name
    end

    def token
      @token ||= credentials.token
    end
end
