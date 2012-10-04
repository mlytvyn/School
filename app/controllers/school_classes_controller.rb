class SchoolClassesController < ApplicationController
  before_filter :signed_in_user, 
                only: [:index, :edit, :update, :assign, :destroy]

  def show
    @school_class = SchoolClass.find(params[:id])
  end

  def new
    @school_class = SchoolClass.new
  end

  def edit
    @school_class = SchoolClass.find(params[:id])
  end

  def index
    @school_classes = SchoolClass.search(params[:search], params[:page])
    # @school_classes = SchoolClass.search(params[:search], params[:user_type], params[:page])
  end

  def create
    @school_class = SchoolClass.new(params[:school_class])
    if @school_class.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @school_class
    else
      render 'new'
    end
  end

  def update
    if @school_class.update_attributes(params[:school_class])
      flash[:success] = "Class info updated"
      redirect_to @school_class
    else
      render 'edit'
    end
  end

  def destroy
    SchoolClass.find(params[:id]).destroy
    flash[:success] = "Class destroyed."
    redirect_to school_classes_url
  end
end
