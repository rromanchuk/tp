class SystemsController < ApplicationController

  respond_to :json
  
  def environment
    @environment = {:environment => "Debug"}
    respond_with @environment
  end
  
end