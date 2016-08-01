class ProConController < ApplicationController

  get '/lists/:list_id/:procon/new' do
    @list = find_list
    @procon = pro_or_con
    erb :"/procons/create_procons"
  end

  post '/lists/:list_id/:procon' do
    @list = find_list
    procon = procon_class.create(params[:item])
    procon.update(user_id: current_user.id, list_id: @list.id)
    redirect "/lists/#{@list.id}"
  end

  get '/lists/:list_id/:procon/:procon_id/edit' do
    @list = find_list
    if !belongs_to_current_user?(@list) || !logged_in?
      redirect "/lists/#{@list.id}"
    end
    @procon = pro_or_con
    @item = find_procon
    erb :"/procons/edit_procons"
  end

  patch '/lists/:list_id/:procon/:procon_id' do
    procon = find_procon
    procon.update(params[:item])
    redirect "/lists/#{params[:list_id]}"
  end

  delete '/lists/:list_id/:procon/:procon_id/delete' do
    @list = find_list

    if !belongs_to_current_user?(@list) || !logged_in?
      redirect "/lists/#{@list.id}"
    end

    find_procon.delete
    redirect "/lists/#{@list.id}"
  end



  private

    def find_list
      List.find(params[:list_id])
    end

    def pro_or_con
      params[:procon]
    end

    def procon_class
      pro_or_con.classify.constantize
    end

    def find_procon
      procon_class.find(params[:procon_id])
    end


end
