class StepList
  require 'markaby'

  def initialize
    @mab = Markaby::Builder.new
    @list_elements = Array.new
  end

  def addStep step_text, img_name
    @list_elements.push lambda {li step_text.chomp; div.image {img src:img_name}}
  end

  def generate
    my_var = @list_elements
    step_list = lambda {ol{my_var.each{|element| instance_exec &element}}}
    @mab.html{body{instance_exec &step_list}}
    @mab.to_s
  end
end