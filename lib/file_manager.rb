class BuilderFileManager
  def initialize example
    @documentation_directory = example.metadata[:directory]
    @documentation_images = example.metadata[:doc_pics]
  end

  def copytext_source
    Rails.root.join "active_documentation/documentation/"<<@documentation_directory<<"/"<<@documentation_directory<<"_copytext.txt"
  end

  def copytext_root
    Rails.root.join "active_documentation/documentation/"<<@documentation_directory
  end

  def formatting_source
    Rails.root.join "active_documentation/formatting/formatting.txt"
  end

  def html
    Rails.root.join "active_documentation/documentation/"<<@documentation_directory<<".html"
  end

  def image_for step_number
    Rails.root.join "active_documentation/documentation/"<<@documentation_directory<<"/"<<@documentation_images[step_number]
  end

  def copytext_already_exists?
    File.exists? copytext_source
  end

  def copytext_root_already_exists?
    Dir.exists? copytext_root
  end
end
