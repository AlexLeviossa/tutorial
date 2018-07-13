# frozen_string_literal: true

class PhrasesController < ApplicationController

  before_action :set_phrase!, only: %i[show edit update destroy vote]
  before_action :check_user!, only: %i[edit update destroy]

  def index
    @phrases = Phrase.includes(:user).paginate(page: params[:page], per_page: 10)
  end

  def show
    @examples = @phrase.examples.includes(:user).paginate(page: params[:page])
    @example = @phrase.examples.build(user_id: current_user.id)
  end

  def new
    @phrase = Phrase.new
    @phrase.examples.build(user_id: current_user.id)
  end

  def create
    @phrase = current_user.phrases.new(phrase_params)
    if @phrase.save
      flash[:notice] = 'Phrase has been created'
      @phrase.create_activity(key: 'create', owner: current_user)
      redirect_to root_path
    else
      flash[:danger] = @phrase.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @phrase.update_attributes(phrase_params)
      flash[:notice] = 'Phrase has been updated!'
      redirect_to user_path(@phrase.user)
    else
      flash[:danger] = @phrase.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @phrase.destroy
    redirect_to root_path
  end

  def vote
    vote_global(@phrase)
    redirect_back(fallback_location: root_path)
  end

  private

  def phrase_params
    params.require(:phrase).permit(:phrase, :translation, examples_attributes: %i[example user_id])
  end

  def set_phrase!
    @phrase = Phrase.friendly.find(params[:id])
  end

  def check_user!
    unless @phrase.author? current_user
      flash[:danger] = 'You are don\'t an author of phrase, go away!'
      redirect_back(fallback_location: root_path)
    end
  end
end
