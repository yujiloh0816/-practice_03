class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :home_controller?
  before_action :authenticate_action!, only: [:edit, :update, :destroy]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_obj, only: [:show, :edit, :update, :destroy], unless: :devise_controller?

  def index
    instance_variable_set("@#{obj_name.pluralize}", klass.all)
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if obj.update(send "#{obj_name}_params")
        format.html { redirect_to obj, notice: "#{obj_name.camelize} was successfully updated." }
        format.json { render :show, status: :ok, location: obj }
      else
        format.html { render :edit }
        format.json { render json: obj.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    obj.destroy
    respond_to do |format|
      format.html { redirect_to (send "#{obj_name.pluralize}_url"), notice: "#{obj_name.camelize} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end

  def home_controller?
    params[:controller] == 'home'
  end

  def authenticate_action!; end

  def set_obj
    instance_variable_set("@#{obj_name}", klass.find(params[:id]))
  end

  def obj
    instance_variable_get("@#{obj_name}")
  end

  def obj_name
    params[:controller].singularize
  end

  def klass
    obj_name.camelize.constantize
  end

end
