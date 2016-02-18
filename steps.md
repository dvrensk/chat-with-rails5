# An empty page

`rails g controller rooms show`

    # config/routes:
    root to: 'rooms#show'

`start rails s`

    # app/rooms/show
    <h1>Chat room</h1>

# A channel for chat

    rails g channel
    rails g channel room speak

turn on 2 things:

* cable.coffee: uncomment App etc
* config/routes: mount cable

in browser console:

    App.cable
    App.room.speak()

# Let client send data

coffee:

- speak take param and pass it message:message

Say sth, check log

    App.room.speak("Hello there!")

# Server listens to messages

channel:

- make speak accept data
- log the data
- say sth again

      ActionCable.server.broadcast "room_channel", message: data["message"]

* RESTART SERVER!
* say sth again

# Contents of subscription

    # def subscribed
    stream_from 'room_channel'

* RESTART SERVER!
* say sth again

# Process what client receives

    # coffee:
    received(data) -> alert data["message"]

* web browser reconnects automatically but we need to reload to get the js
* say sth again
* check two browsers
* We have a full roundtrip!

# UI

    <form>
      <label>Say something</label><br>
      <input type="text" data-behaviour="room_speaker">
    </form>

Define that behaviour in same coffee file

    $(document).on "keypress", "[data-behaviour~=room_speaker]", (event) ->
        if event.keyCode is 13 # return => send
            App.room.speak event.target.value
            event.target.value = ""
            event.preventDefault()

Say "Hello from box"

# Display messages in page

    #show
    <div id="messages"></div>

    # coffee
    $('#messages').append data["message"]

* say "hello"
* yay!
* say "hi"
* oh. ugly.

let's render

    # app/views/messages/_message.html.erb
    <div class="message">
      <p><%= message %></p>
    </div>

    # room_channel.rb:
      ActionCable.server.broadcast "room_channel", message: render_message(message)
    end

    private \
    def render_message(message)
      ApplicationController.renderer.render(partial: "messages/message", locals: {message: message})
    end

* try again
* yay!  We have IRC-style chat!

# Add persistence

    rails g model message content:text
    rails db:migrate

    rails c
    Message.create content: "¡Hola Barcelona!"
    exit

    # RoomsController#show:
    @messages = Message.all

    # app/rooms/show
    <h1>Chat room</h1>

    <div id="messages">
      <%= render @messages %>
    </div>

    # _message.html.erb
    <div class="message">
      <p><%= message.content %></p>
    </div>

* Reload.  ¡Hola!
* Say sth.  Oh no.

.

    # channel
    def speak(data)
      message = Message.create! content: data["message"]
      ActionCable.server.broadcast "room_channel", message: render_message(message)
    end

* Say sth.  Yay! 
* Reload page.  Yay again!

# Delay sending

    rails g job MessageBroadcast

    # MessageBroadcastJob:
    def perform(message)
      ActionCable.server.broadcast "room_channel", message: render_message(message)
    end

    private \
    def render_message(message)
      ApplicationController.renderer.render(partial: "messages/message", locals: {message: message})
    end

# Asynch is hard

    # message.rb
    after_create_commit { MessageBroadcastJob.perform_later(self) }
