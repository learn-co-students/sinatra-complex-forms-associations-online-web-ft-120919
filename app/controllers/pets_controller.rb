class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    #Needs knowledge of all existing owners
    @owners = Owner.all
    #binding.pry
    #Render form for creating a new pet
    #Choose an existing owner, or create a new one
    erb :'/pets/new'
  end

  post '/pets' do 
    #binding.pry
    if params[:pet].keys.include?("owner_id")
      @pet = Pet.create(name: params[:pet][:name], owner_id: params[:pet][:owner_id])
  
    elsif !params[:owner][:name].empty?
      new_owner = Owner.create(name: params[:owner][:name])
      @pet = Pet.create(name: params[:pet][:name])
      @pet.owner = new_owner
      new_owner.pets << @pet
    end #if

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find_by(id: params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    #binding.pry
    @pet = Pet.find_by(id: params[:id])
    @pet.update(name: params[:pet][:name])
    #binding.pry 

    if !params[:owner][:name].empty? 
      new_owner = Owner.create(name: params[:owner][:name])
      @pet.owner = new_owner
      new_owner.pets << @pet 
    elsif params[:pet].keys.include?("owner_id") 
      @pet.update(owner: Owner.find_by(id: params[:pet][:owner_id]))

    end
    redirect to "pets/#{@pet.id}"
  end
end