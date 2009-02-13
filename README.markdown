Camatar v.0.1
=====================================================

Plugin for models to use Camatar server.



Usage
=====================================================

First fill out config/camatar.yml: 

    development:
      api_key: 24a0625a2ee063ac6fa39fc0b5e4d0fbe677548b2158ee9bd8e8d034e3fa2ebe
      domain: localhost:3001
      rtmp: rtmp://localhost/camatar
      default_duration: 60

### Generator

    script/generate camatar Model

### Model

    class Video < ActiveRecord::Base
      this_is_camatar
    end
    
### Controller
    
    # after_create creates authorization token
    @video = Video.create
    
    # after recorded to kick off saving process
    @video.camatar_save 
    
    # check if recorded & saved
    @video.camatar_valid? 



Recorder
=====================================================
 
### flashvars:
 
     type = "rtmp"
     streamer => Camatar::domain
 
     max_record_time => duration (@video.camatar_max_duration)
 
     file => initial video (@video.camatar_flv_url)
     image => initial image (@video.camatar_image_url)

     token => recording authorization token (@video.camatar_token)
 
     rtmp_url => camatar domain (Camatar::domain)
 
     save_callback => javascript callback when save button pressed ("save()")

     skin => camatar skin to use ("/iballz_skin.swf")
 
     width = w;
     height = h;
     fullscreen = "true";
     controlbar = "over";
     tracecall = "flash"; // debug
 
--- 

Copyright (c) 2009 Nick Merwin, released under the MIT license
