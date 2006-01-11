class AccountController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # To require logins, use:
  #
  #   before_filter :login_required                            # restrict all actions
  #   before_filter :login_required, :only => [:edit, :update] # only restrict these actions
  # 
  # To skip this in a subclassed controller:
  #
  #   skip_before_filter :login_required

  # say something nice, you goof!  something sweet.
  def index
    redirect_to(:action => 'signup') unless logged_in? or User.count > 0
  end

  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if current_user
      redirect_back_or_default(:controller => 'gallery', :action => 'index')
      flash[:notice] = "Logged in successfully"
    end
  end

  def signup
    @user = User.new(params[:user])
    return unless request.post?
    if @user.save
      redirect_back_or_default(:controller => 'gallery', :action => 'index')
      flash[:notice] = "Thanks for signing up!"
    end
  end
  
  # Sample method for activating the current user
  #def activate
  #  @user = User.find_by_activation_code(params[:id])
  #  if @user and @user.activate
  #    self.current_user = @user
  #    redirect_back_or_default(:controller => '/account', :action => 'index')
  #    flash[:notice] = "Your account has been activated."
  #  end
  #end

  def logout
    self.current_user = nil
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => 'gallery', :action => 'index')
  end
end
