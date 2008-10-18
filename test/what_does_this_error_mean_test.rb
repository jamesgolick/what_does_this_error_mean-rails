require File.dirname(__FILE__)+'/test_helper'

class WhatDoesThisErrorMeanTest < ActionController::TestCase
  tests SomethingsController

  def test_rescue_action_locally_should_render_local_diagnostics_page_instead_of_rails_one
    @controller.stubs(:add_variables_to_assigns)
    @controller.response.stubs(:content_type=)
    @controller.response.stubs(:headers)
    @controller.stubs(:render_for_file)

    template = mock
    template.expects(:assign_variables_from_controller)

    template.expects(:render_file).with(File.expand_path('./test/../lib/../templates/diagnostics.erb'), false)

    @controller.instance_variable_set("@template", template)
    @controller.send(:rescue_action_locally, ArgumentError.new)
  end

  def test_rescue_action_locally_with_wdtem_should_defer_to_rails_unless_diagnostics_template
    @controller.stubs(:rescue_templates).returns(Hash.new('asdf'))
    exception = ActionController::UnknownAction.new('asdf')
    @controller.expects(:rescue_action_locally_without_wdtem).with(exception)
    @controller.send(:rescue_action_locally, exception)
  end
end
