class UsersController < Clearance::UsersController
before_action :set_user, only: [:show, :edit, :update, :destroy]
before_action :require_login

  def index
    @user = current_user
    @users = User.all
  end

# GET /admin/1
# GET /admin/1.json
def show
  # @user = User.find(params[:id])
end

# GET /admin/1/edit
def edit
  # @user = User.find(params[:id])
end

# POST /admin
# POST /admin.json

# PATCH/PUT /admin/1
# PATCH/PUT /admin/1.json
def update
  respond_to do |format|
    if @user.update(user_params)
      format.html { redirect_to @user, notice: 'User profile was successfully updated.' }
      format.json { render :show, status: :ok, location: @user }
    else
      format.html { render :edit }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end

# DELETE /admin/1
# DELETE /admin/1.json
def destroy
  @user.destroy
  respond_to do |format|
    format.html { redirect_to user_url, notice: 'User profile was successfully destroyed.' }
    format.json { head :no_content }
  end
end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :birthday, :email, :password, :role, :avatar)
  end


end
