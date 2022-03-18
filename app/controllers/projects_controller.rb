class ProjectsController < ApplicationController

  before_action :set_form_vars, only: [:new, :create, :show, :edit, :index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authorise_user, only: [:edit, :update, :destroy]

  def index
    @sorting = ["create date", "ending soon", "need your support"]
    case params[:sort]
    when "1"
      @projects = Project.order(:due_date).includes(:category)
    when "2"
      @projects = Project.order(total_amount: :asc).includes(:category)
    else
      @projects = Project.order(:id).includes(:category)
    end
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
      puts "********* Projects_controller - Create **************"
      pp @project.goal_amount # before_validation input * 100
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
      # set_goal_amount_in_cents
      puts "********* Projects_controller - Update **************"
      pp @project.goal_amount
      redirect_to @project, notice: "#{@project.title.capitalize} is successfully updated"
    else
      set_form_vars
      render "edit", notice: "Something went wrong"
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "#{@project.title.capitalize} is sucessfully deleted"
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
    @options = Option.all
  end

  def authorise_user
    if current_user.id != @project.user_id
      redirect_to projects_path, notice: "You aren't authorised to do that."
    end
  end

end
