class UsersController < ApplicationController

  get '/signup' do
    redirect '/lists' if logged_in?
    erb :'/users/create_user'
  end

  post '/signup' do
    params_hash = {username: params[:username],
                  email: params[:email],
                  password: params[:password]}
    if signup_errors?(params_hash) || params[:password] != params[:confirm_password]
      @errors = []
      @errors < "All fields must be completed." if any_nil?(params_hash)
      @errors << "The username #{params[:username]} is associated to an existing account." if username_exists?(params_hash)
      @errors << "The email #{params[:email]} is associated to an existing account." if email_exists?(params_hash)
      @errors << "Passwords must match." if params["password"] != params["confirm_password"]
      erb :'/users/create_user'
    else
      user = User.create(username: params[:username], email: params[:email], password: params[:password])
      login(user.username, params[:password])
      redirect '/lists'
    end
  end

  get "/users/:name" do
    @user = User.find_by(username: params[:name])
    erb :'/users/show_users_lists'
  end

  get "/users/:name/edit" do
    @user = User.find_by(username: params[:name])
    erb :'/users/edit_user'
  end

  delete '/users/:name/delete' do #delete action
    user = User.find_by(username: params[:name])
    if logged_in? && current_user == user
      logged_in? == false
      user.clear_data
      @message = "User account successfully deleted."
    end
    erb :'index.html'
  end




end
