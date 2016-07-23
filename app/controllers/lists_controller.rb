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
      redirect '/login'
    end
  end

  post '/lists/new' do
    if params[:title] == ""
      @error = "Title of list cannot be left blank."
      erb :'/lists/create_list'
    end
    if logged_in? && params[:title] != ""
      @list = List.new(title: params[:title])
      @list.description = params[:description] if params[:description] != ""
      @list.user_id = current_user.id
      @list.save
      redirect "/lists/#{@list.id}"
    else
      redirect '/lists/new'
    end
  end

  get '/lists/:id/edit' do
    @list = List.find(params[:id])
    if !logged_in?
      redirect "/login"
    elsif current_user.lists.include?(@list) && logged_in?
      erb :'/lists/edit_list'
    else
      erb :'/lists/show_list'
    end
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
    @list = List.find(params[:id])
    if !logged_in?
      redirect "/login" # redirect if not logged in
    else
      current_user.lists.find(params[:id]).update(title: params[:title], description: params[:description])
      redirect "/lists/#{@list.id}"
    end
  end

  delete '/lists/:id/delete' do #delete action
    @errors = []
    list = List.find(params[:id])
    if logged_in? && list == current_user.lists.find(params[:id])
      list.delete
      redirect "/users/#{current_user.username}"
    else
      @errors << "Sorry, your delete action cannot be completed because you were not logged in. Please try again." if !logged_in?
      @errors << "Sorry, your delete action cannot be completed. You may only delete your own lists. Please try again." if list != current_user.lists.find(params[:id])
      erb :"/users/lists/#{params[:id]}"
    end

  end

  get '/lists/:list_id/:procon/new' do
    @list = List.find(params[:list_id])
    @procon = params[:procon]
    erb :"/procons/create_procons"
  end

  get '/lists/:list_id/:procon/:procon_id/edit' do
    @list = List.find(params[:list_id])
    @procon = params[:procon]
    @item = params[:procon].classify.constantize.find(params[:procon_id])
    erb :"/procons/edit_procons"
    # @list = List.find(params[:id].to_i)
    # if current_user.lists.include?(@list) && logged_in?
    #   erb :'/procons/edit_procons'
    # else
    #   erb :'/procons/add_procon'
    # end
  end

  delete '/lists/:list_id/:procon/:procon_id/delete' do
    params[:procon].classify.constantize.find(params[:procon_id]).delete
    redirect "/lists/#{params[:list_id]}"
      # @list = List.find(params[:id].to_i)
    # if current_user.lists.include?(@list) && logged_in?
    #   erb :'/procons/edit_procons'
    # else
    #   erb :'/procons/add_procon'
    # end
  end

  post '/lists/:list_id/:procon/new' do
    @list = List.find(params[:list_id])
    binding.pry
    params[:procon].classify.constantize.create(user_id: current_user.id, list_id: @list.id, weight: params[:weight], description: params[:description])

    redirect "/lists/#{@list.id}"
  end

  post '/lists/:list_id/:procon/:procon_id/edit' do
    # binding.pry
    # @list = List.find(params[:id].to_i)
    # if current_user.lists.include?(@list) && logged_in?
    #   erb :'/procons/edit_procons'
    # else
    #   erb :'/procons/add_procon'
    # end
  end


end
