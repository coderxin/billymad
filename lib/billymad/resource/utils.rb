module Billymad
  module Resource
    module Utils
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def demodulize(path)
          path = path.to_s
          if (i = path.rindex('::'))
            path[(i + 2)..]
          else
            path
          end
        end
      end

      def underscore(camel_cased_word)
        camel_cased_word.to_s.gsub(/::/, '/')
                        .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
                        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
                        .tr('-', '_')
                        .downcase
      end
    end
  end
end

