class FiguresController < ApplicationController

  get '/figures/new' do 
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.new(params[:figure])
    if !params[:title][:name].empty?
      title = Title.new(name: params[:title][:name])
      title.save
      @figure.titles << title 
    end
    if !params[:landmark][:name].empty?
      landmark = Landmark.new(name: params[:landmark][:name])
      landmark.save
      @figure.landmarks << landmark
    end
    @figure.save
    # redirect('/figures/#{@figure.id}')
  end

  get '/figures' do
    erb :'figures/index'
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    @figure.name = params[:figure][:name] if !params[:figure][:name].empty?
    if !params[:new_landmark].empty?
      landmark = Landmark.new(name: params[:new_landmark])
      landmark.save
      @figure.landmarks << landmark
    end
    @figure.save
    redirect("/figures/#{params[:id]}")
  end
end