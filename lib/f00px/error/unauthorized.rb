module F00px
  class Error

    class Unauthorized < F00px::Error
      STATUS_CODE = 401
    end

    register_error(Unauthorized)

  end
end
