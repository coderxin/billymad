require 'billymad/version'
require 'billymad/configuration'
require 'billymad/errors'

require 'billymad/extensions/string'

module Billymad
  module Request
    autoload :Proxy,              'billymad/request/proxy'
    autoload :Info,               'billymad/request/info'
    autoload :Base,               'billymad/request/base'
    autoload :Rest,               'billymad/request/rest'
  end

  module Resource
    autoload :Base,               'billymad/resource/base'
    autoload :Association,        'billymad/resource/association'
    autoload :Validations,        'billymad/resource/validations'
    autoload :CollectionProxy,    'billymad/resource/collection_proxy'
    autoload :Utils,              'billymad/resource/utils'
  end

  autoload :Account,              'billymad/resources/account'

  autoload :Client,               'billymad/resources/client'
  autoload :ClientProperty,       'billymad/resources/client_property'
  autoload :ClientPropertyValue,  'billymad/resources/client_property_value'
  autoload :ClientTag,            'billymad/resources/client_tag'

  autoload :Contact,              'billymad/resources/contact'

  autoload :Article,              'billymad/resources/article'
  autoload :ArticleProperty,      'billymad/resources/article_property'
  autoload :ArticlePropertyValue, 'billymad/resources/article_property_value'
  autoload :ArticleTag,           'billymad/resources/article_tag'

  autoload :Unit,                 'billymad/resources/unit'

  autoload :Invoice,              'billymad/resources/invoice'
  autoload :InvoiceItem,          'billymad/resources/invoice_item'
  autoload :InvoiceComment,       'billymad/resources/invoice_comment'
  autoload :InvoicePayment,       'billymad/resources/invoice_payment'
  autoload :InvoiceTag,           'billymad/resources/invoice_tag'

  autoload :Template,             'billymad/resources/template'
  autoload :Setting,              'billymad/resources/setting'

  autoload :User,                 'billymad/resources/user'
  autoload :UserProperty,         'billymad/resources/user_property'
  autoload :UserPropertyValue,    'billymad/resources/user_property_value'

  autoload :Role,                 'billymad/resources/role'

  module Operations
    autoload :General, 'billymad/operations/general'
    autoload :All,     'billymad/operations/all'
    autoload :Find,    'billymad/operations/find'
    autoload :Create,  'billymad/operations/create'
    autoload :Update,  'billymad/operations/update'
    autoload :Destroy, 'billymad/operations/destroy'
  end

  class << self
    # A Billymad configuration object. Must act like a hash and return sensible
    # values for all Billymad configuration options. See Billymad::Configuration.
    attr_writer :configuration

    # Call this method to modify defaults.
    #
    # @example
    #   Billymad.configure do |config|
    #     config.billomat_id  = 'billy_madness'
    #     config.api_key      = 'abcd1234567890'
    #   end
    def configure
      yield(configuration)
    end

    # The configuration object.
    # @see Billymad.configure
    def configuration
      @configuration ||= Configuration.new
    end
  end
end

