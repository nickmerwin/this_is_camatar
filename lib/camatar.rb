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
      
      def camatar_valid?
        !self.camatar_duration.blank?
      end
    
      def camatar_authorize
        begin
          @camatar_video = Camatar::Api::Video.create :max_duration => Camatar::default_duration
          self.camatar_token = @camatar_video.token
          self.camatar_max_duration = @camatar_video.max_duration
          save
        rescue ActiveResource::ServerError
          
        rescue ActiveResource::UnauthorizedAccess, ActiveResource::ForbiddenAccess
        
        end
      end
    
      def camatar_deauthorize
        
      end
    
      def camatar_save
        video = Camatar::Api::Video.get :finish, :token => self.camatar_token

        self.camatar_flv_url = video["flv_url"]
        self.camatar_image_url = video["image_url"]
        self.camatar_thumb_url = video["thumb_url"]
        self.camatar_duration = video["duration"]
        save
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