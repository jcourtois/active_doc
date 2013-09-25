class DocBuilder
  require 'markaby'
  require_relative 'patches/Markaby'

  def initialize
    Markaby::Builder.set(:tagset, Markaby::HTML5)
    @mab = Markaby::Builder.new
    @list_elements = Array.new
  end

  def addStep step_text, img_name
    @list_elements.push lambda {li step_text; div.image {img src:img_name}}
  end

  def generate documentation={}, doc_invariant={}
    steps = @list_elements
    @mab.html{
      tag! :article, {}
      head{
        title{documentation[:title]} if documentation[:title]
        link href:doc_invariant[:with][:css] if doc_invariant[:with] && doc_invariant[:with][:css]
        text doc_invariant[:with][:js] if doc_invariant[:with] && doc_invariant[:with][:js]
      }
      body{
        text doc_invariant[:with][:header] if doc_invariant[:with] && doc_invariant[:with][:header]
        tag!(:article, class: 'manual col-sm-9 pull-right'){
          h1{documentation[:heading]} if documentation[:heading]
          div.error{} if documentation[:if_error]
          ol{steps.each{|element| instance_exec &element}}
        }
      }
    }
    @mab.to_s
  end
end