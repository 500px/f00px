module ConfigMock

  include F00px::Configuration

  def middleware?
    !!credentials[:consumer_key]
  end

  def credentials
    {
      consumer_key: ENV['CONSUMER_KEY'],
      consumer_secret: ENV['CONSUMER_SECRET'],
      token: ENV['TOKEN'],
      token_secret: ENV['TOKEN_SECRET']
    }
  end

end
