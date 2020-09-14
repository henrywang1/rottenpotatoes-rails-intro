class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    if params[:ratings] == nil || params[:clicked_header]  == nil
      if params[:ratings] == nil
        params[:ratings] = session[:ratings] ||  Movie.all_ratings
      end
      if params[:clicked_header] == nil
        params[:clicked_header] = session[:clicked_header] || ""
      end

      session[:ratings] = params[:ratings]
      session[:clicked_header] = params[:clicked_header]
      flash.keep
      redirect_to movies_path(:clicked_header => session[:clicked_header], :ratings => session[:ratings])
    end
    if params[:ratings] != Movie.all_ratings
      @checked_ratings = params[:ratings]
      @checked_ratings = @checked_ratings.keys() unless @checked_ratings.class == Array
      @movies = Movie.with_rating(@checked_ratings)
    else
      @movies = Movie.all
      @checked_ratings = Movie.all_ratings
    end
      @movies = @movies.order(params[:clicked_header])
      session[:ratings] = params[:ratings]
      session[:clicked_header] = params[:clicked_header]
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
end
