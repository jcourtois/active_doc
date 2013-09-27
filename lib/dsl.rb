#This is a module to extend Gizmo mix-ins
module DSL
  @page

  def where_we_have(*module_names)
    puts module_names
    on_page_with(module_names.at(0)){|page| @page=page; yield page}
  end

  def step step_number, action_name, optional_args={}
    example.metadata[:doc_steps].store step_number, action_name
    args = optional_args[:with] || {}
    args[:img] = optional_args.fetch(:img) if optional_args.has_key?(:img)
    @page.perform action_name, args
  end

end