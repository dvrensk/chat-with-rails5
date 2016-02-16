class RoomsController < ApplicationController
  def show
    @messages = Message.order(created_at: :desc).where(room_id: params[:id])
  end
end
