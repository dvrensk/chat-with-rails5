App.room_id = document.location.pathname.split("/").pop()

App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: App.room_id },
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#messages').prepend data["message"]

  speak: (message, opts) ->
    @perform 'speak', message: message, room_id: opts["room"]

$(document).on "keypress", "[data-behaviour~=room_speaker]", (event) ->
	if event.keyCode is 13 # 13 is return key
		App.room.speak event.target.value, room: App.room_id
		event.target.value = ""
		event.preventDefault()
