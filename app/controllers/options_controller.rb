class OptionsController < ApplicationController
  # this controller is for manipulating options
  
  before_action :set_project_id, only: [:new, :create, :update, :destroy]
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
      render edit_option_path(@project_id)
    end
  end

  def destroy
    @option.destroy
    redirect_to project_path(@project_id), notice: "#{@option.title.capitalize} option is sucessfully deleted"
  end

  private

  def option_params
    params.require(:option).permit(:title, :amount, :description)
  end

  def set_option
    @option = Option.find(params[:id])
  end

  def set_project_id
    @project_id = session[:project_id]
  end
end
