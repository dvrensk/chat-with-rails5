class RoomsController < ApplicationController
  def show
    @messages = Message.order(created_at: :desc)
  end
end
