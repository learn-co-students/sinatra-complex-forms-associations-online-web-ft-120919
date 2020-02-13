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
    @pet = Pet.create(:name=>params["pet_name"])
    if !!params["owner_id"]
      if !params["owner_id"].empty?
        @pet.owner = Owner.find(params["owner_id"])
      end
    end
    if !!params["owner_name"]
      if !params["owner_name"].empty?
        @pet.owner = Owner.create(:name=>params["owner_name"])
      end
    end
    @pet.save
    #binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do

    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    #binding.pry
    @pet =  Pet.find(params[:id])
    @pet.update(:name=>params["pet_name"])

    if !!params["owner"]["name"]
      if !params["owner"]["name"].empty?
        o = Owner.find(params["owner"]["name"])
        @pet.owner=o
      end
    end

    if !!params["owner_name"]
      if !params["owner_name"].empty?
        o = Owner.create(:name=>params["owner_name"])
        @pet.owner=o
      end
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end