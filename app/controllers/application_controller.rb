require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "prosandcons"
  end


  get "/" do
    if logged_in?
      redirect "/lists"
    end
    erb :'/index.html'
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def login(username, password)
      # is the user who they claim to be
      # check if the user exists, if so set session
      user = User.find_by(username: username)
      if user && user.authenticate(password)
        # if statement assignment
        session[:username] = username

      end
      # otherwise redirect
    end

    def logout!
      session.clear
    end

    def current_user
      @current_user ||= User.find_by(:username => session[:username])
      # returns user if already set or finds and sets user
    end

    def signup_errors?(params)
      any_nil?(params) || username_exists?(params) || email_exists?(params) || username_spaces?(params)
    end

    def login_errors?(params)
      any_nil?(params) || !username_exists?(params) || !password_match?(params)
    end


    def any_nil?(params)
      [params[:username], params[:password], params[:email]].include?("")
    end

    def username_exists?(params)
      User.find_by(username: params[:username])
    end

    def username_spaces?(params)
      params[:username].include?(" ")
    end

    def email_exists?(params)
      User.find_by(:email => params[:email])
    end

    def password_match?(params)
      if username_exists?(params)
        User.find_by(username: params[:username]).try(:authenticate, params[:password])
      else
        true
      end
    end

    def belongs_to_current_user?(list)
      list.user_id == current_user.id
    end
  end

end
