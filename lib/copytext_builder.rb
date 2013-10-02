require 'pry'

class CopytextBuilder
  def initialize destination
    @destination = destination
  end

  def generate_default_copytext_with steps

    FileUtils.cp copytext_template, @destination
    File.open(@destination, 'a') do |f|
      steps.each {|step_number, step_text| f.puts "#{step_number}. #{step_text}"}
      f.puts closing
    end
  end

  def copytext_template
    Rails.root.join "active_documentation/lib/copytext_template.txt"
  end

  def closing
    "---closing\nAdd optional closing text here."
  end
end