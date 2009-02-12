Camatar v.0.1
=============

Plugin for models to use Camatar server.

---

Usage
=====

First fill out config/camatar.yml

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

---
 
Recorder
======== 
 
## Loading camatar.swf from js
# flashvars:
 
     type = "rtmp"
 
     streamer => Camatar::domain
 
     max_record_time => duration ("60")
 
     file => initial video ("asdf.flv")
     image => initial image ("asdf.jpg")

     token => recording authorization token ("asdf")
 
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
