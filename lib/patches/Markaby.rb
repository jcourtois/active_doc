
module Markaby
  class HTML5
    class << self
      attr_accessor :tags, :tagset, :forms, :self_closing, :doctype
    end

    @doctype = ['html']
    @tagset = XHTMLTransitional.tagset.merge({
                                              :abbr => Attrs,
                                              :article => Attrs,
                                              :aside => Attrs,
                                              :audio => Attrs,
                                              :canvas => Attrs,
                                              :datalist => Attrs,
                                              :details => Attrs,
                                              :figure => Attrs,
                                              :footer => Attrs,
                                              :header => Attrs,
                                              :hgroup => Attrs,
                                              :mark => Attrs,
                                              :menu => Attrs,
                                              :meter => Attrs,
                                              :nav => Attrs,
                                              :output => Attrs,
                                              :progress => Attrs,
                                              :section => Attrs,
                                              :time => Attrs,
                                              :video => Attrs
                                             })

    @tags = @tagset.keys
    @forms = @tags & FORM_TAGS
    @self_closing = @tags & SELF_CLOSING_TAGS
  end
end