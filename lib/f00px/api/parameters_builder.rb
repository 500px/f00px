module F00px
  module ParametersBuilder

    def initialize
      @params = {}
    end

    def images(*images)
      @params[:image_size] = Array(images)
      self
    end

    def include_states(v)
      @params[:include_states] = !!v
      self
    end

    def options(opts)
      images(*opts[:images]) if opts[:images]
      @params.merge!(opts)
      self
    end

    def build
      @params
    end

  end
end
