class ListsController < ApplicationController

  get '/lists' do
    if logged_in?
        erb :'lists/lists'
    else
      redirect '/'
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
      redirect '/'
    end
  end

  post '/lists' do
    @errors = []
    binding.pry
    if params[:list][:title] != "" || params[:list][:description] != ""
      @errors << "List title and description cannot be blank."
      erb :'lists/create_list'
    else
      @list = List.create(params["list"])
      @list.user_id = current_user.id
      if @list.save
        redirect "/lists/#{@list.id}"
      else
        @errors = @list.errors
        erb :'lists/create_list'
      end
    end
  end

  get '/lists/:id' do
    @list = find_list_id

    if logged_in?
      erb :'/lists/show_list'
    else
      redirect '/'
    end
  end

  get '/lists/:id/edit' do
    @list = find_list_id
    if !logged_in?
      redirect "/login"
    elsif current_user.lists.include?(@list) && logged_in?
      erb :'/lists/edit_list'
    else
      @errors = [""]
      erb :'/lists/show_list'
    end
  end

  patch '/lists/:id' do
    @list = find_list_id
    if !logged_in? || !current_user.lists.find(params[:id])
      redirect "/login" # redirect if not logged in
    else
      @list.update(params[:list])
      redirect "/lists/#{@list.id}"
    end
  end

  delete '/lists/:id/delete' do #delete action
    @errors = []
    list = find_list_id
    if logged_in? && list == current_user.lists.find(params[:id])
      list.delete
      redirect "/users/#{current_user.username}"
    else
      @errors << "Sorry, your delete action cannot be completed because you were not logged in. Please try again." if !logged_in?
      @errors << "Sorry, your delete action cannot be completed. You may only delete your own lists. Please try again." if list != current_user.lists.find(params[:id])
      erb :"/lists/#{params[:id]}"
    end
  end

  private

     def find_list_id
       List.find(params[:id])
     end


end
