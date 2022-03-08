class OptionsController < ApplicationController
  # this controller is for editing options
  
  before_action :set_project_id, only: [:new, :create]
  before_action :set_option, only: [:show, :edit, :update, :destroy]
  
  def index
    @options = Option.all
  end

  def show
  end

  def new
    @option = Option.new
    
  end

  def create
    @option = Option.new(option_params)
    @option.project_id = @project_id
    # pp @project_id
    # pp @option
    if @option.save
      # puts "==============================================="
      # pp "saved"
      redirect_to project_path(@project_id)
    else
      # puts "==============================================="
      # pp "something went wrong"
      render "new"
    end
  end

  def edit
  end

  def update
    @option.update(option_params)
    if @option.save
      # puts "==============================================="
      # pp "saved"
      redirect_to root_url, notice: "GREAT!"
    else
      # puts "==============================================="
      # pp "WHAT!?!?!?!?"
      render "edit"
    end
  end

  def destroy
    @option.destroy
    redirect_to projects_path, notice: "#{@option.title} sucessfully deleted"
  end

  private

  def option_params
    params.require(:option).permit(:title, :amount, :description)
  end

  def set_option
    @option = Option.find(params[:id])
  end

  def set_project_id
    # @project_id = params[:project_id]
    @project_id = session[:project_id]
    pp @project_id
  end
end
