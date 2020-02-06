class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    # binding.pry
    if params[:pet].keys.include?("owner_id")
      @pet = Pet.create(name: params[:pet][:name], owner_id: params[:pet][:owner_id])
    # here - how to associate @pet to its owner?
    elsif !params["owner"]["name"].empty?
      owner = Owner.create(name: params[:owner][:name])
      @pet = Pet.create(name: params[:pet][:name])
      @pet.owner = owner
      owner.pets << @pet
    end
    # binding.pry
    redirect to "/pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @owners = Owner.all 
    @pet = Pet.find(params[:id])
    erb :"/pets/edit"
  end

  patch '/pets/:id' do 
    # binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name])

    if !params["owner"]["name"].empty? 
      owner = Owner.create(name: params[:owner][:name])
      @pet.owner = owner
      owner.pets << @pet  
    elsif params[:pet].keys.include?("owner_id")
      @pet.update(owner_id: params[:pet][:owner_id])
    # here - how to associate @pet to its owner?
    end

    redirect to "pets/#{@pet.id}"
  end
end