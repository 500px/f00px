module F00px
  module Queue

    def queue(&block)
      queue = Runner.new(connection)
      queue.user_id = user_id if user_id
      yield(queue)
      queue.run!
    end

  end

end
