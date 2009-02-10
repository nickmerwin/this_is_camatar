# Camatar Plugin
# by Nick Merwin 02.06.09
# * faciliations communication with Camatar server

module Camatar
  
  # ==========================
  # Configuration
  # ==========================

  class << self
    attr_accessor :domain, :default_duration, :api_key
  
    def configure
      opts = YAML::load(File.open("#{RAILS_ROOT}/config/camatar.yml"))
    
      @defaut_duration = opts[RAILS_ENV]['default_duration']
      @domain = opts[RAILS_ENV]['domain']
      @api_key = opts[RAILS_ENV]['api_key']
      
      Api::Base.user = "api"
      Api::Base.password = @api_key
      Api::Base.site = "http://#{@domain}"
    end
  end
  
  # ==========================
  # ActiveRecord extensions
  # ==========================

  module AR
    class << self
      def included(base) #:nodoc:
        base.extend ClassMethods
      end
    end
    
    module ClassMethods
      def this_is_camatar(opts={})
        include InstanceMethods
        
        after_create :camatar_authorize
        
        opts[:max_duration_column] ||= :max_duration
        opts[:token_column] ||= :token
        
        write_inheritable_attribute :camatar_opts, opts
      end
      
      def camatar_opts
        read_inheritable_attribute(:camatar_opts)
      end
    end
  
    module InstanceMethods
      attr_accessor :camatar_video
    
      def camatar_authorize
        begin
          @camatar_video = Camatar::Api::Video.create :max_duration => Camatar::default_duration
          self.send "#{camatar_opts[:token_column]}=", @camatar_video.token
          self.send "#{camatar_opts[:max_duration_column]}=", @camatar_video.max_duration
        rescue ActiveResource::ServerError
          
        rescue ActiveResource::UnauthorizedAccess, ActiveResource::ForbiddenAccess
        
        end
      end
    
      def camatar_deauthorize
        
      end
    
      def camatar_save
        @camatar_video.put(:finish)
      end
    
      def camatar_delete
      
      end
    end
  end
  
  # ==========================
  # ActiveResource API clients
  # ==========================

  module Api
    class Base < ActiveResource::Base
      
    end

    class Video < Base

    end
    
  end
  
end

# ==========================
# Initialize
# ==========================

Camatar::configure

if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send(:include, Camatar::AR)
end