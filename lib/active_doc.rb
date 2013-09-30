#require "active_doc/version"
require_relative 'doc_reader'
require_relative 'doc_builder'
require 'pry'

class ActiveDoc
  def generate example, with={}
    documentation = pull_copytext_from_source Rails.root.join("active_documentation/documentation/" + example.metadata[:directory] + "/" + example.metadata[:copy])
    formatting = pull_formatting_from_source Rails.root.join("active_documentation/formatting/" + with[:formatting])
    builder = DocBuilder.new
    example.metadata[:doc_steps].each do |step_no, step_name|
      #sort the steps?  steps could be out of order

      step_screenshot = Rails.root.join("active_documentation/documentation/"+example.metadata[:directory]+"/"+example.metadata[:doc_pics][step_no])
      builder.add_step step_name.to_s, step_screenshot
    end
#documentation[:steps].each{|step| builder.addStep step, example.metadata[:doc_pics] }

    html_text = builder.full_html_generate documentation, formatting
    File.open(Rails.root.join("active_documentation/documentation/" + example.metadata[:doc]),'w'){|f| f.write(html_text)}
  end

  def pull_copytext_from_source filename
    DocReader.new.parse_copytext filename
  end

  def pull_formatting_from_source filename
    DocReader.new.parse_formatting filename
  end
end