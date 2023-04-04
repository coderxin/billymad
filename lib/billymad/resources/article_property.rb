module Billymad
  class ArticleProperty < Resource::Base
    include Billymad::Operations::General

    mandatory_attributes_for :create, attributes: %i[name type]

    def self.plural_resource_name
      'article-properties'
    end
  end
end

