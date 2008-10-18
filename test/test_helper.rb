$LOAD_PATH << File.dirname(__FILE__)
RAILS_ROOT = File.dirname(__FILE__)
RAILS_ENV  = 'test'

require 'rubygems'
require 'action_controller'
require 'action_controller/test_case'
require 'action_view'
require 'test_help'
require 'mocha'
require 'test/unit'

require File.dirname(__FILE__)+'/../lib/what_does_this_error_mean'
require File.dirname(__FILE__)+'/../init'

class SomethingsController < ActionController::Base; end


