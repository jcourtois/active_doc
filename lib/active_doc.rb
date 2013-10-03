#require "active_doc/version"
require_relative 'doc_reader'
require_relative 'doc_builder'
require_relative 'file_manager'
require_relative 'copytext_builder'
require 'pry'

class ActiveDoc
  def initialize example
    @file_manager = BuilderFileManager.new example
    @example_steps = example.metadata[:doc_steps]
  end

  def generate_documentation
    print_warning_to_terminal_and_generate_file_with_copytext unless file_with.copytext_already_exists?

    copytext[:steps].each{|step_number, step_text| builder.add_step(step_text, file_with.image_for(step_number))}
    File.open(file_with.html,'w'){|f| f.write(html_text)}
  end

  private
  def html_text
    builder.full_html_generate copytext, formatting
  end

  def copytext
    reader.parse_copytext(file_with.copytext_source)
  end

  def formatting
    reader.parse_formatting(file_with.formatting_source)
  end

  def print_warning_to_terminal_and_generate_file_with_copytext
    puts "Hey, we don't have a copytext file.  We'll make a default one for you, lazy."

    generate_directory(directory_with.copytext_root) unless directory_with.copytext_root_already_exists?
    CopytextBuilder.new(file_with.copytext_source).generate_default_copytext_with @example_steps
  end

  def generate_directory directory_path
    Dir.mkdir directory_path
  end

  def file_with
    @file_manager
  end

  def directory_with
    @file_manager
  end

  def builder
    @builder||=DocBuilder.new
  end

  def reader
    @reader||=DocReader.new
  end
end