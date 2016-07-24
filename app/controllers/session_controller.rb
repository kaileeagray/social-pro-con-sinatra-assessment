class SessionsController < ApplicationController

  get '/login' do
    if logged_in?
      flash[:message] = "You are logged in."
      redirect '/lists'
    end
    erb :'users/login'
  end

  post '/login' do
    if login_errors?(params)
      @errors = []
      @errors << "All fields must be completed." if any_nil?(params)
      @errors << "The username #{params[:username]} is not associated to an existing account." if !username_exists?(params)
      @errors << "Password is incorrect." if !password_match?(params)
      erb :'/users/login'
    else
      login(params[:username], params[:password])
      redirect '/lists' if logged_in?
    end
  end

  get '/logout' do
    logout! if logged_in?
    redirect '/'
  end

end
