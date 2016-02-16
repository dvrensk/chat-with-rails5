class AddRoomIdToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :room_id, :integer
    Message.update_all "room_id = 1"
    change_column_null :messages, :room_id, false
    add_index :messages, :room_id
  end
end
