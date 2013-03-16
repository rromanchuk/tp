class SystemsController < ApplicationController

  respond_to :json
  
  def environment
    @environment = {:environment => "Distribution"}
    respond_with @environment
  end
  
end