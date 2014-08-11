class GamesController < ApplicationController
  def new
    @player = User.new
    @players = User.all
    if Setting.first == nil
      @settings = Setting.new
    else
      @settings = Setting.first
    end
  end

  def create
    @player = User.create(name: params[:user][:name].capitalize, score: 0 )

    if @player.valid?
    @player.save
    redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def latecomer
    players = User.order(:position)
    @player = User.create(name: params[:user][:name], score: 0, position: players.last.position + 1 )

    if @player.valid?
      @player.save
      redirect_to games_path
    else
      redirect_to games_path
    end
  end

  def clear
    @players = User.all
    @players.destroy_all
    redirect_to root_path
  end

  def start_game
    User.shuffle
    User.zero_scores
    if Setting.first == nil
      @settings = Setting.create(streak: 3, end: 10)
      @settings.save
    end
    redirect_to games_path
  end

  def index
    if User.all.count < 3
      redirect_to root_path, notice: "Must have at least three players to start"
    end
    @latecomer = User.new
    @players = User.order(:position)
  end

  def winner
    @settings = Setting.first

    users = User.order(:position)
    loser = User.find(params[:loser])
    loser.position = (users.last.position + 1)
    loser.streak = 0
    loser.save

    winner = User.find(params[:winner])
    winner.score += 1
    winner.streak += 1
    winner.save

    if winner.score.to_i == @settings.end.to_i
      redirect_to game_over_path(id: winner.id)
    elsif winner.streak.to_i == @settings.streak.to_i
      winner.streak = 0
      update = User.order(:position)
      winner.position = (update.last.position + 1)
      winner.save
      redirect_to games_path, notice: "#{@settings.streak} wins in a row!"
    else
      redirect_to games_path
    end
  end

  def settings
    if Setting.first == nil
      @current = Setting.create(streak: params[:setting][:streak], end: params[:setting][:end])
      @current.save if @current.valid?
      redirect_to root_path
    else
      @current = Setting.first
      @current.streak = params[:setting][:streak]
      @current.end = params[:setting][:end]
      @current.save if @current.valid?
      redirect_to root_path
    end
  end

  def game_over
    @winner = User.find(params[:id])
  end

end