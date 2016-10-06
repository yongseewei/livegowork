class UsersController < Clearance::UsersController
  def new
    @user = user_from_params
    render template: "users/new"
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

  def url_after_create
    Clearance.configuration.redirect_url
  end

  def user_from_params
    first_name =user_params.delete(:first_name)
    last_name =user_params.delete(:last_name)
    dob = user_params.delete(:dob)
    gender = user_params.delete(:gender)
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.first_name =first_name
      user.last_name =last_name
      user.dob = dob
      user.gender = gender
      user.email = email
      user.password = password
    end
  end

  def user_params
    params[Clearance.configuration.user_parameter] || Hash.new
  end

end
