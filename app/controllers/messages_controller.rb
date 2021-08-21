# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params.merge(user: current_user))
    if @message.valid?
      @message.save
      @carpool = @message.conversation.carpool
    else
      render :new
    end
  end

  protected

  def message_params
    params.require(:message).permit(:body, :carpool_id, :conversation_id)
  end
end
