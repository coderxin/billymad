module Billymad
  class ArticleProperty < Base
    include Billymad::Operations::General

    mandatory_attributes_for :create, attributes: [ :name, :type ]

    def self.plural_resource_name
      'article-properties'
    end
  end
end