#require "ActiveDoc/version"
require_relative 'DocReader'
require_relative 'StepList'

class ActiveDoc
  def generate
    documentation = DocReader.new.parse_copytext 'sandwich.txt'
    sl = StepList.new
    documentation[:steps].each{|step| sl.addStep step, 'hello.png' }
    sl.generate
  end
end

puts ActiveDoc.new.generate