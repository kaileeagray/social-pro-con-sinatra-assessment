class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    if any_nil?(params)
      @error = true
      redirect '/signup'
    else
      user = User.create(params)
      login(user.username, params[:password])
      redirect '/lists'
    end
  end

end
