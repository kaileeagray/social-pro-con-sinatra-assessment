class UsersController < ApplicationController

  get '/signup' do
    redirect '/choices' if logged_in?
    erb :'/users/create_user'
  end

  post '/signup' do
    if any_nil?(params)
      @error = true
      redirect '/signup'
    else
      user = User.new
      user.username = params[:username]
      user.email = params[:email]
      user.password = params[:password]
      login(user.username, user.password)
      redirect '/choices'
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/choices/show_users_choices'
  end


end
