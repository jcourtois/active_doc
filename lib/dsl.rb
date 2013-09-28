#This is a module to extend Gizmo mix-ins
module DSL
  @page

  def where_we_have(*module_names)
    on_page_with(*module_names){|page| @page=page; yield page}
  end
  #consider not using metaprogramming here

  define_method :step do |step_number, action_name, optional_args={}|
    perform_step_for example, step_number, action_name, optional_args
  end

  def perform_step_for example, step_number, action_name, arguments
    example.metadata[:doc_steps].store step_number, action_name
    args = optional_args[:with] || {}

    if optional_args[:img]
      example.metadata[:doc_pics].store step_number, optional_args[:img]
      args[:img] = optional_args[:img]
    end
    @page.perform action_name, args
  end
end