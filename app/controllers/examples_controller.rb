# frozen_string_literal: true

class ExamplesController < ApplicationController
  before_action :set_phrase!
  before_action :check_user!, only: :destroy

  def create
    @example = @phrase.examples.new(example_params)
    if @example.save
      flash[:notice] = 'Example has been created'
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

  def upvote
    @example = @phrase.examples.find_by(id: params[:id])
    if current_user.voted_for? @example
      redirect_to phrase_path(@phrase)
    else
      @example.upvote_by current_user
      @example.user.increase_karma_example
      redirect_to phrase_path(@phrase)
    end
  end

  def downvote
    @example = @phrase.examples.find_by(id: params[:id])
    if current_user.voted_for? @example
      redirect_to phrase_path(@phrase)
    else
      @example.upvote_by current_user
      @example.user.decrease_karma_example
      redirect_to phrase_path(@phrase)
    end
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

