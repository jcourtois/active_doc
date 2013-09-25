class DocBuilder
  require 'markaby'

  def initialize
    @mab = Markaby::Builder.new
    @list_elements = Array.new
  end

  def addStep step_text, img_name
    @list_elements.push lambda {li step_text; div.image {img src:img_name}}
  end

  def generate documentation={}, doc_invariant={}
    my_var = @list_elements
    step_list = lambda {ol{my_var.each{|element| instance_exec &element}}}
    @mab.html{
      head{
        title{documentation[:title]} if documentation[:title]
        link href:doc_invariant[:with][:css] if doc_invariant[:with][:css]
        text doc_invariant[:with][:js] if doc_invariant[:with][:js]
      }
      body{
        text doc_invariant[:with][:header] if doc_invariant[:with][:header]
        h1{documentation[:heading]} if documentation[:heading]
        div.error{} if documentation[:if_error]
        instance_exec &step_list
      }
    }
    @mab.to_s
  end
end