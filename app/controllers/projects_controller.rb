class ProjectsController < ApplicationController

  before_action :set_form_vars, only: [:new, :create, :show, :edit, :index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authorise_user, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all
  end
  
  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      # If a user create a project, the user type will be changed into Organiser
      if current_user.type != "Organiser"
        current_user.update(type: "Organiser")
      end
      session[:project_id] = @project.id
      redirect_to new_option_path

    else
      render "new", notice: "Something went wrong"
    end
  end

  def show
    @option = @options.where(project_id: @project.id)
    session[:project_id] = @project.id
    @total_supporters = Support.where(project_id: @project.id).count

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

  def data_summary
  
  end

  def project_params
    params.require(:project).permit(:title, :category_id, :start_date, :due_date, :goal_amount, :description, :picture)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def set_form_vars
    @categories = Category.all
    @statuses = ["ongoing", "upcoming", "completed"]
    @options = Option.all
  end

  def authorise_user
    if current_user.id != @project.user_id
      redirect_to projects_path, notice: "You aren't authorised to do that."
    end
  end

end
