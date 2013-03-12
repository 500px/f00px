module F00px
  module ParametersBuilder

    def initialize
      @params = {}
    end

    def images(*images)
      @params[:images] = Array(images)
      self
    end

    def include_states(v)
      @params[:include_states] = !!v
      self
    end

    def options(opts)
      @params.merge!(opts)
      self
    end

    def build
      @params
    end

  end
end
