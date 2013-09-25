#require "ActiveDoc/version"
require_relative 'DocReader'
require_relative 'DocBuilder'


class ActiveDoc
  def generate
    documentation = pull_copytext_from_source 'sandwich.txt'
    invariants = pull_formatting_from_source 'formatting.txt'
    builder = DocBuilder.new

    documentation[:steps].each{|step| builder.addStep step, 'hello.png' }

    html_text = builder.generate documentation, with:invariants
    puts html_text
    #File.open('output.html','w'){|f| f.write(html_text)}
  end

  def pull_copytext_from_source filename
    DocReader.new.parse_copytext filename
  end

  def pull_formatting_from_source filename
    DocReader.new.parse_formatting filename
  end
end

puts ActiveDoc.new.generate