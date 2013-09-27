#require "active_doc/version"
require_relative 'doc_reader'
require_relative 'doc_builder'


class ActiveDoc
  def generate example, with={}
    #TODO:store the goal information in the metadata / generate the copytext file automatically
    documentation = pull_copytext_from_source example.metadata[:copy]
    formatting = pull_formatting_from_source with[:formatting]
    builder = DocBuilder.new
    example.metadata[:doc_steps].each do |step_no, step_name|
      step_screenshot = example.metadata[:doc_pics][step_no]
      builder.addStep step_name.to_s, step_screenshot
    end
#documentation[:steps].each{|step| builder.addStep step, example.metadata[:doc_pics] }

    html_text = builder.full_html_generate documentation, formatting
    File.open(example.metadata[:doc],'w'){|f| f.write(html_text)}
  end

  def pull_copytext_from_source filename
    DocReader.new.parse_copytext filename
  end

  def pull_formatting_from_source filename
    DocReader.new.parse_formatting filename
  end
end