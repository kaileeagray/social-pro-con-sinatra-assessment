class UsersController < ApplicationController

  get '/signup' do
    redirect '/lists' if logged_in?
    erb :'/users/create_user'
  end

  post '/signup' do
    if signup_errors?(user_hash) || params[:password] != params[:confirm_password]
      @errors = []
      @errors << "All fields must be completed." if any_nil?(user_hash)
      @errors << "Username cannot contain spaces." if username_spaces?(user_hash)
      @errors << "The username #{params[:username]} is associated to an existing account." if username_exists?(user_hash)
      @errors << "The email #{params[:email]} is associated to an existing account." if email_exists?(user_hash)
      @errors << "Passwords must match." if params["password"] != params["confirm_password"]
      erb :'/users/create_user'
    else
      user = User.create(user_hash)
      login(user.username, params[:password])
      redirect '/lists'
    end
  end

  get "/users" do
    if logged_in?
      erb :'/users/all_users'
    else
      redirect "/login"
    end
  end

  get "/users/:name" do
    @user = find_by_username
    erb :'/users/show_users_lists'
  end


  delete '/users/:name/delete' do #delete action
    user = find_by_username
    if logged_in? && current_user == user
      logout!
      user.destroy
    end
    redirect '/'
  end

  private

    def find_by_username
      User.find_by(username: params[:name])
    end

    def user_hash
      {username: params[:username], email: params[:email], password: params[:password]}
    end

end
