class SessionsController < ApplicationController

  get '/login' do
    redirect '/lists' if logged_in?
    erb :'users/login'
  end

  post '/login' do
    binding.pry

    login(params[:username], params[:password])
    redirect '/lists' if logged_in?
  end

  get '/logout' do
    logout! if logged_in?
    redirect '/login'
  end

end
