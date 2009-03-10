module SimplifiedMetatags

  class ActionController::Base

    protected

    # <link rel="video_src" href="<%= video_flash_url @informativo %>"/>
    # <meta name="video_height" content="321" />
    # <meta name="video_width" content="400" />
    # <meta name="video_type" content="application/x-shockwave-flash" />
    # <meta name="medium" content="video" />
    def add_meta_video(video_src, height, width, video_type = "application/x-shockwave-flash", medium = "video")
      @meta_video = []
      @meta_video << link('video_src', video_src)
      @meta_video << meta('video_height', height)
      @meta_video << meta('video_width', width)
      @meta_video << meta('video_type', video_type)
      @meta_video << meta('medium', medium)

      @meta_video.join!("\n")
    end

    def self.add_meta_video(content, options = {})
      before_filter options do |controller|
        controller.send(:add_meta_video, content)
      end
    end
    
    def add_meta_image_src(content)
      @meta_image_src = link('image_src', content)
    end

    def self.add_meta_image_src(content, options = {})
      before_filter options do |controller|
        controller.send(:add_meta_image_src, content)
      end
    end

    ##
    #
    #
    def add_meta_description(content)
      @meta_description = meta('description', content)
    end

    ##
    #
    #
    def self.add_meta_description(content, options = {})
      before_filter options do |controller|
        controller.send(:add_meta_description, content)
      end
    end

    ##
    #
    #
    def add_meta_keywords(content)
      @meta_keywords = meta('keywords', content)
    end

    def self.add_meta_keywords(content, options = {})
      before_filter options do |controller|
        controller.send(:add_meta_keywords, content)
      end
    end

    ##
    #
    #
    def meta(name, content)
      %(<meta name="#{name}" content="#{content}" />)
    end

    def link(rel, href)
      %(<link rel="#{rel}" href="#{href}"/>)
    end
  end

  module Helper

    def metatags
      @metatags = []
      @metatags << @meta_description
      @metatags << @meta_keywords
      @metatags << @meta_image_src
      @metatags << @meta_video
      return @metatags.join("\n") rescue nil
    end

  end

end

ActionController::Base.send(:include, SimplifiedMetatags)
ActionView::Base.send(:include, SimplifiedMetatags::Helper)