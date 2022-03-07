class RewardsController < ApplicationController
  include Wicked::Wizard
  # before_action :set_project, only: [:show, :update]
  steps :first, :second

  def show
    @option = Project.find(session[:project_id])
    
    puts "that's great!"
    render_wizard
  end

  def update
    @option = Project.find(session[:project_id])
    @option.update(option_params)
    pp @option

    puts "that's REALLY awesome!"
    render_wizard @option
  end

  def option_params
    params.permit(:option1_title, :option1_amount, :option1_details, :option2_title, :option2_amount, :option2_details)
  end

end
