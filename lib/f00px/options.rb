module F00px
  module Options

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def defaults
        @defaults ||= {}
      end

      def option(name, options = {})
        self.defaults[name] = options[:default]


        class_eval <<-RUBY
          def #{name}
            settings['#{name}'.to_sym] || F00px::Configuration.defaults['#{name}'.to_sym]
          end

          def #{name}=(value)
            settings['#{name}'.to_sym] = value
          end

          def #{name}?
            !!#{name}
          end
        RUBY
      end

    end

    def reset
      settings.replace(defaults)
    end

    def settings
      @settings ||= {}
    end

  end
end
