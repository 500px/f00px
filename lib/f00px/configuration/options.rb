module F00px
  module Configuration
    module Options

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods

        def defaults
          @defaults ||= {}
        end

        def options
          self.defaults.keys
        end

        def option(name, options = {})
          self.defaults[name] = options[:default]

          class_eval <<-RUBY
            def #{name}
              settings['#{name}'.to_sym] || #{self}.defaults['#{name}'.to_sym]
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
end
