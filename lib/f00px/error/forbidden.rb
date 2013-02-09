module F00px
  class Error

    class Forbidden < F00px::Error
      STATUS_CODE = 403
    end

    register_error(Forbidden)
  end
end
