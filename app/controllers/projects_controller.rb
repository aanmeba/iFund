class ProjectsController < ApplicationController
  before_action :set_form_vars, only: [:new, :create, :show, :edit, :index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end
  
  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      redirect_to projects_path, notice: "Succesfully created"
    else
      render "new", notice: "Something went wrong"
    end
  end

  def show
  end

  def edit
  end

  def update
    @project.update(project_params)
    if @project.save
      redirect_to @project, notice: "Project successfully updated"
    else
      set_form_vars
      render "edit", notice: "Something went wrong"
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "#{@project.title} sucessfully deleted"
  end

  private

  def project_params
    params.require(:project).permit(:title, :category_id, :start_date, :due_date, :goal_amount, :description, :picture)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def set_form_vars
    @categories = Category.all
  end

end
