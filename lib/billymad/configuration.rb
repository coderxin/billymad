require "logger"

module Billymad  
  class Configuration

    BILLOMAT_HOST = 'billomat.net'

    attr_accessor :billomat_id, :api_key, :secure, :logger
    attr_accessor :api_format

    def initialize
      @billomat_id = nil
      @api_key = nil
      @secure = true
      @logger = default_logger
      
      set_defaults
    end

    def api_url
      _verify_configuration
      @api_url ||= billomat_url
    end

  private

    attr_reader :billomat_host

    def set_defaults
      @api_format    = :json
      @billomat_host = BILLOMAT_HOST
    end

    def protocol
      @protocol ||= @secure ? 'https' : 'http' 
    end

    def billomat_url
      "#{protocol}://#{billomat_id.to_s}.#{billomat_host}/api/"
    end

    def default_logger
      logger = Logger.new(STDOUT)
      logger.level = Logger::INFO
      logger
    end

    def _verify_configuration
      _verify_billomat_id
      _verify_api_key
    end

    def _verify_api_key
      raise Billymad::ConfigurationError.new("You must specify an API key") if api_key.nil?
    end

    def _verify_billomat_id
      raise Billymad::ConfigurationError.new("You must specify an Billomat ID") if billomat_id.nil?
    end

  end
end