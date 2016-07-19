class ListsController < ApplicationController

  get '/lists' do
    if logged_in?
        erb :'lists/lists'
    else
      redirect '/login'
    end
  end

  get '/new' do
    redirect '/lists/new'
  end

  get '/lists/:id/new' do
    redirect '/lists/new'
  end

  get '/lists/new' do
    if logged_in?
        erb :'lists/create_list'
    else
      redirect '/login'
    end
  end

    post '/list' do
      # if logged_in? && params[:list] != ""
      #   list = list.new(content: params[:list])
      #   list.user_id = @current_user.id
      #   list.save
      # else
      #   redirect '/lists/new'
      # end
    end

    get '/lists/:id/edit' do

      @list = List.find(params[:id].to_i)
      erb :'/lists/edit_list'
      # if current_user.lists.include?(@list) && logged_in?
      #
      # else
      #   erb :'/lists/show_list'
      # end
      # if !logged_in?
      #   redirect "/login" # redirect if not logged in
      # else
      #   if list = current_user.lists.find_by(params[:id])
      #     erb :'/lists/edit_list'
      #   else
      #     redirect '/lists'
      #   end
      # end
    end

    get '/lists/:id' do
      @list = List.find(params[:id].to_i)
      if current_user.lists.include?(@list) && logged_in?
        erb :'/lists/user_show_list'
      else
        erb :'/lists/show_list'
      end
      # if logged_in?
      #   @list = list.find(params[:id].to_i)
      #   erb :'/lists/show_list'
      # else
      #   redirect '/login'
      # end
    end





    post '/lists/:id/edit' do
      # if !logged_in?
      #   redirect "/login" # redirect if not logged in
      # elsif params[:list] == ""
      #   erb :'/lists/edit_list'
      # else
      #   current_user.lists.find_by(params[:id]).update(content: params[:list])
      #   redirect '/lists'
      # end
    end

    delete '/lists/:id/delete' do #delete action
      binding.pry
      @errors = []
      list = List.find(params[:id])
      if logged_in? && list == current_user.lists.find(params[:id])
        list.delete
        redirect "/lists"
      else
        @errors << "Sorry, your delete action cannot be completed because you were not logged in. Please try again." if !logged_in?
        @errors << "Sorry, your delete action cannot be completed. You may only delete your own lists. Please try again." if list != current_user.lists.find(params[:id])
        erb :"/users/lists/#{params[:id]}"
      end

    end

    get '/lists/:id/procons/new' do
      @list = List.find(params[:id].to_i)
      if current_user.lists.include?(@list) && logged_in?
        redirect "/lists/#{params[:id]}/edit"
      else
        erb :'/procons/suggest_procons'
      end
    end


end
