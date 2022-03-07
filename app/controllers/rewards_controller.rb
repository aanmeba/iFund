class RewardsController < ApplicationController
  include Wicked::Wizard
  steps :first, :second

  def show 
    # @option = Project.find(session[:project_id])
    @option = Option.new(project_id: session[:project_id])
    @option.save
    puts "that's great!"
    pp @option
    render_wizard
  end
  
  def update 
    # @option = Project.find(session[:project_id])
    # @option.update(option_params)
    
    @option = Option.new(project_id: session[:project_id])
    @option.save
    pp @option
    puts "that's REALLY awesome!"
    render_wizard @option
      
  end

  # def option_params
  #   params.permit(:option1_title, :option1_amount, :option1_details, :option2_title, :option2_amount, :option2_details)
  # end

  private
  def redirect_to_finish_wizard_path
    redirect_to projects_path, notice: "Successfully created"
  end

end
