class PetsController < ApplicationController
require 'pry'

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all 
    erb :'/pets/new'
  end

  post '/pets' do 
    #binding.pry 
   @pet = Pet.create(params[:pet])
   if params[:owner][:name] != ""
     @pet.owner = Owner.create(name: params[:owner][:name])
    
   end 
   @pet.save 
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
   get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end


  patch '/pets/:id' do 
    #binding.pry 
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name])
    @pet.update(owner_id: params[:pet][:owner_id])
    if params[:owner][:name]  !=""
       @pet.owner = Owner.create(name: params[:owner][:name])
       @pet.save 
    end 
    
    redirect "/pets/#{@pet.id}"
    
  end
end 