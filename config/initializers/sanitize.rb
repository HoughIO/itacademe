module ITAcademe
  # See https://github.com/rgrove/sanitize/
  def self.get_video_iframe_transformer
    lambda do |env|
      node = env[:node]
      node_name = env[:node_name]

      # Don't continue if this node is already whitelisted or is not an element.
      return if env[:is_whitelisted] || !node.element?

      # Don't continue unless the node is an iframe.
      return unless node_name == 'iframe'

      # Verify that the iframe source is actually a YouTube or Vimeo video.
      youtube_regex = /\Ahttps?:\/\/(?:www\.)?youtube(?:-nocookie)?\.com\//
      vimeo_regex = /\Ahttps?:\/\/(?:www\.)?(?:player\.)?vimeo\.com\//
      return unless node['src'] =~ youtube_regex || node['src'] =~ vimeo_regex

      # We're now certain that this is a video embed, but we still need to run
      # it through a special Sanitize step to ensure that no unwanted elements
      # or attributes that don't belong in a video embed can sneak in.
      Sanitize.clean_node!(node, {
        :elements => %w[iframe],
        :attributes => {
          'iframe'  => %w[allowfullscreen frameborder height src width
                          webkitallowfullscreen mozallowfullscreen]
        }
      })

      # Now that we're sure that this is a valid video embed and that there are
      # no unwanted elements or attributes hidden inside it, we can tell
      # Sanitize to whitelist the current node.
      {:node_whitelist => [node]}
    end
  end

  SANITIZE_FILTER = {
    remove_contents: ['script'],
    elements: %w[a abbr address b blockquote br cite code dd dl dt em h2 h3 h4
                 hr i img li ol p pre s small span strong sub sup table thead
                 tfoot tbody th td tr u ul],
    attributes: {
      :all => %w[class],
      'a' => %w[href title],
      'blockquote' => %w[cite],
      'img' => %w[alt src title width height],
      'ol' => %w[start type],
      'span' => %w[class],
      'td' => %w[colspan rowspan],
      'th' => %w[colspan rowspan scope]
    },
    protocols: {
      'a' => {
        'href' => ['http', 'https', 'mailto', :relative]
      },
      'img' => {
        'src' => ['http', 'https', :relative]
      }
    },
    transformers: ITAcademe::get_video_iframe_transformer()
  }
end
