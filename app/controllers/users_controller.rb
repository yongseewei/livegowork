class UsersController < Clearance::UsersController
  before_action :find_user, only: [:show, :edit, :destroy, :update]

  def new
    @user = user_from_params
    render template: "users/new"
  end

  def show
  end

  def create
    @user = user_from_params
    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  def edit
    @user = current_user
  end

  def show
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render template: "users/edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_from_params
    first_name =user_params.delete(:first_name)
    last_name =user_params.delete(:last_name)
    dob = user_params.delete(:dob)
    gender = user_params.delete(:gender)
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    avatar = user_params.delete(:avatar)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.first_name =first_name
      user.last_name =last_name
      user.dob = dob
      user.gender = gender
      user.email = email
      user.password = password
      user.avatar = avatar
    end
  end

  # def user_params
  #   params[Clearance.configuration.user_parameter] || Hash.new

  def url_after_create
    Clearance.configuration.redirect_url
  end

  def user_params
    params.require(:user).permit(:email,:first_name,:last_name,:password,:avatar,:user_id)
  end
  
end
