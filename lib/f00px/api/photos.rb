module F00px
  module Api
    module Photos

      def popular(*args)
        options = get_options(args)
        builder = args.first
        builder ||= Builder.new

        params = builder
          .feature('popular')
          .options(options)
          .build

        self.get('photos', params)
      end

      def user_photos(*args)
        options = get_options(args)
        user_id, builder = args
        builder ||= Builder.new

        params = builder
          .feature('user')
          .user_id(user_id)
          .options(options)
          .build

        self.get('photos', params)
      end

      class Builder
        include ParametersBuilder

        def feature(f)
          @params[:feature] = f
          self
        end

        def user_id(uid)
          @params[:user_id] = uid
          self
        end
      end

      private
      def get_options(args)
        if args.last.is_a?(Hash)
          options = args.pop
        else
          options = {}
        end
        options
      end
    end
  end
end
