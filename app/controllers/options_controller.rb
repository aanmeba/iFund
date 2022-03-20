class OptionsController < ApplicationController
  # this controller is for manipulating options
  
  before_action :set_project_id, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_option, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @option = Option.new
  end

  def create
    @option = Option.new(option_params)
    @option.project_id = @project_id
    if @option.save
      redirect_to project_path(@project_id)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @option.update(option_params)
    if @option.save
      redirect_to project_path(@project_id), notice: "#{@option.title.capitalize} option has been added"
    else
      render "edit"
    end
  end

  def destroy
    @option.destroy
    redirect_to project_path(@project_id), notice: "#{@option.title.capitalize} option is sucessfully deleted"
  end

  private

  # set option params
  def option_params
    params.require(:option).permit(:title, :amount, :description)
  end

  # set an option instance
  def set_option
    @option = Option.find(params[:id])
  end

  def set_project_id
    # store the project_id from either session or params
    if session[:project_id] || params[:project_id]
      @project_id = session[:project_id]
    end
  end
end
