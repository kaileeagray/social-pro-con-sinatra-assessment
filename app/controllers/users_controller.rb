class UsersController < ApplicationController

  get '/signup' do
    redirect '/lists' if logged_in?
    erb :'/users/create_user'
  end

  post '/signup' do
    binding.pry
    if signup_errors?(params)
      @errors = []
      @errors < "All fields must be completed." if any_nil?(params)
      @errors << "The username #{params[:username]} is associated to an existing account." if username_exists?(params)
      @errors << "The email #{params[:email]} is associated to an existing account." if email_exists?(params)
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

end
