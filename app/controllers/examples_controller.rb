# frozen_string_literal: true

class ExamplesController < ApplicationController
  before_action :set_phrase!
  before_action :set_example!
  before_action :check_user!, only: :destroy

  def create
    @example = @phrase.examples.new(example_params)
    if @example.save
      flash[:notice] = 'Example has been created'
      @example.create_activity(key: 'create', owner: current_user, recipient: @phrase.user)
      redirect_to phrase_path(@phrase)
    else
      flash[:danger] = @example.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    @phrase.examples.find(params[:id]).destroy
    flash[:notice] = 'Example has been deleted!'
    redirect_to phrase_path(@phrase)
  end

  def vote
    vote_global(@example)
    redirect_to root_path
  end

  private

  def set_example!
    @example = @phrase.examples.find_by(id: params[:example_id])
  end

  def set_phrase!
    @phrase = Phrase.friendly.find(params[:phrase_id])
  end

  def example_params
    params.require(:example).permit(:example, :user_id)
  end

  def check_user!
    unless @phrase.author? current_user
      flash[:danger] = 'Не трогай, а то вычислю по айпи!'
      redirect_to phrase_path(@phrase)
    end
  end
end

