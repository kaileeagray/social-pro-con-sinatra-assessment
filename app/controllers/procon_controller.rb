class ProConController < ApplicationController

  get '/lists/:list_id/:procon/new' do
    @list = List.find(params[:list_id])
    @procon = params[:procon]
    erb :"/procons/create_procons"
  end

  get '/lists/:list_id/:procon/:procon_id/edit' do
    @list = List.find(params[:list_id])
    if !belongs_to_current_user?(@list) || !logged_in?
      redirect "/lists/#{@list.id}"
    end
    @procon = params[:procon]
    @item = params[:procon].classify.constantize.find(params[:procon_id])
    erb :"/procons/edit_procons"

  end

  get '/lists/:list_id/:procon/:procon_id/delete' do
    @list = List.find(params[:list_id])

    if !belongs_to_current_user?(@list) || !logged_in?
      redirect "/lists/#{@list.id}"
    end

    params[:procon].classify.constantize.find(params[:procon_id]).delete
    redirect "/lists/#{@list.id}"
  end

  post '/lists/:list_id/:procon/new' do
    @list = List.find(params[:list_id])
    params[:procon].classify.constantize.create(user_id: current_user.id, list_id: @list.id, weight: params[:weight], description: params[:description])
    redirect "/lists/#{@list.id}"
  end

  post '/lists/:list_id/:procon/:procon_id/edit' do
    procon = params[:procon].classify.constantize.find(params[:procon_id])
    procon.update(description: params[:description], weight: params[:weight])
    redirect "/lists/#{params[:list_id]}"
  end


end
