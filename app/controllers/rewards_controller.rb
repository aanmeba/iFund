class RewardsController < ApplicationController
  include Wicked::Wizard
  steps :first, :second

  def show 
    # @option = Project.find(session[:project_id])
    # if params["update"]
    #   @option.find_by(session[:project_id])
    # else
      @option = Option.new
    # end
    render_wizard
  end
  
  def update 
    # @option = Project.find(session[:project_id])
    # @option.update(option_params)
    
    @option = Option.new(option_params)
    @option.project_id = session[:project_id]
  
    pp @option
    puts "that's REALLY awesome!"
    render_wizard @option
      
  end

  def option_params
    params.require(:option).permit(:title, :amount, :description)
  end

  private
  def redirect_to_finish_wizard_path
    redirect_to projects_path, notice: "Successfully created"
  end

end
