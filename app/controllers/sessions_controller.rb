class SessionsController < Clearance::SessionsController

  def create_from_omniauth

    auth_hash = request.env["omniauth.auth"]

    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      @next = root_url
      @notice = "You're signed in again with fb"
    else
      user = User.create_with_auth_and_hash(authentication,auth_hash)
      @next = edit_user_path(user)
      @notice = "Signed in first time with facebook"
    end
    sign_in(user)
    redirect_to @next, :notice => @notice
  end

  def create
    @user = authenticate(params)

    sign_in(@user) do |status|
      if status.success?
        redirect_to params[:session][:this_url], notice: "Sign in successfully!"
      else
        flash[:notice] = status.failure_message
        respond_to do |format|
          format.js 
        end
        flash.clear
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  end
