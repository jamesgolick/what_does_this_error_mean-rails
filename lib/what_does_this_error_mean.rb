module WhatDoesThisErrorMean
  def self.included(receiver)
    receiver.class_eval { alias_method_chain :rescue_action_locally, :wdtem }
  end

  def rescue_action_locally_with_wdtem(exception)
    return rescue_action_locally_without_wdtem unless rescue_templates[exception] == 'diagnostics'

    add_variables_to_assigns
    @template.instance_variable_set("@exception", exception)
    @template.instance_variable_set("@rescues_path", File.dirname(rescues_path("stub")))
    @template.send!(:assign_variables_from_controller)

    @template.instance_variable_set("@contents", @template.render_file(File.dirname(__FILE__)+'/../templates/diagnostics.erb', false))

    response.content_type = Mime::HTML
    render_for_file(rescues_path("layout"), response_code_for_rescue(exception))
  end
end

