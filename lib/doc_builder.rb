class DocBuilder
  require 'markaby'
  require_relative 'patches/markaby'

  def initialize
    Markaby::Builder.set(:tagset, Markaby::HTML5)
    @mab = Markaby::Builder.new
    @list_elements = Array.new
  end

  def add_step step_text, img_name=nil
    @list_elements.push lambda {li step_text; div.image {img src:img_name} if img_name}
  end

  def full_html_generate doc={}, doc_formatting={}
    steps = @list_elements
    @mab.html{
      head{
        title{doc[:title]} if doc[:title]
        link href:doc_formatting[:css] if doc_formatting[:css]
        text doc_formatting[:js] if doc_formatting[:js]
      }
      body{
        text doc_formatting[:header] if doc_formatting[:header]
        tag!(:article, class: 'manual col-sm-9 pull-right'){
          h1{doc[:heading]} if doc[:heading]
          div.error{} if doc[:if_error]
          ol{steps.each{|element| instance_exec &element}}
        }
      }
    }
    @mab.to_s
  end

  def hook_html_generate documentation={}, doc_invariant={}

  end
end