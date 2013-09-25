#require "ActiveDoc/version"
require_relative 'DocReader'
require_relative 'DocBuilder'

class ActiveDoc
  def generate
    documentation = pull_copytext_from_source 'sandwich.txt'
    invariants = pull_formatting_from_source 'js.txt'
    builder = DocBuilder.new

    documentation[:steps].each{|step| builder.addStep step, 'hello.png' }
    builder.generate documentation, with:invariants
  end


  def pull_copytext_from_source filename
    DocReader.new.parse_copytext filename
  end

  def pull_formatting_from_source filename
    {css:'hello.css', js:'<script src="lala"></script>'}
  end
end

puts ActiveDoc.new.generate