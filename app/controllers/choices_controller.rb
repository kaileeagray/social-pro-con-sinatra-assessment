class ChoicesController < ApplicationController

  # get '/choices' do
  #   if logged_in?
  #       erb :'choices/choices'
  #   else
  #     redirect '/login'
  #   end
  # end
  #
  # get '/choices/new' do
  #   if logged_in?
  #       erb :'choices/create_choice'
  #   else
  #     redirect '/login'
  #   end
  # end
  #
  # post '/choice' do
  #   if logged_in? && params[:choice] != ""
  #     choice = choice.new(content: params[:choice])
  #     choice.user_id = @current_user.id
  #     choice.save
  #   else
  #     redirect '/choices/new'
  #   end
  # end
  #
  # get '/choices/:id' do
  #   if logged_in?
  #     @choice = choice.find(params[:id].to_i)
  #     erb :'/choices/show_choice'
  #   else
  #     redirect '/login'
  #   end
  # end
  #
  #
  #
  # get '/choices/:id/edit' do
  #   if !logged_in?
  #     redirect "/login" # redirect if not logged in
  #   else
  #     if choice = current_user.choices.find_by(params[:id])
  #       erb :'/choices/edit_choice'
  #     else
  #       redirect '/choices'
  #     end
  #   end
  # end
  #
  # post '/choices/:id/edit' do
  #   if !logged_in?
  #     redirect "/login" # redirect if not logged in
  #   elsif params[:choice] == ""
  #     erb :'/choices/edit_choice'
  #   else
  #     current_user.choices.find_by(params[:id]).update(content: params[:choice])
  #     redirect '/choices'
  #   end
  # end
  #
  # delete '/choices/:id/delete' do #delete action
  #   choice = choice.find(params[:id])
  #   if logged_in? && choice == current_user.choices.find_by(params[:id])
  #     choice.delete
  #   end
  # end

end
