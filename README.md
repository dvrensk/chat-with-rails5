# Chatting with Rails 5

For this exercise, you start out in the state where we left off after building the
naive chat system that [DHH demonstrates on the Rails homepage](http://rubyonrails.org/).
The goal of the exercise is to add _rooms_ to allow for different conversations at the same time.

You can go about this pretty much any way you want, but I've listed some ideas for
inspiration to save you some time.  If you have lots of time and want to feel that you are doing
this without help, feel free to stop reading here.

## Hints / guidelines

* Make each room available as `/rooms/1`, `/rooms/2`, etc.  Using `resources`
  is probably the easiest solution.
* You don't have to create actual room models or a database table.  It's enough
  that the messages table gets a `room_id` column.  Think of it as leaving the
  room implementation details for later.
* Remember that ActionCable classes do not reload automatically.  You will need to
  restart the server quite often.
* Until Rails 5 is released, ActionCable will not be documented at the usual places.
  Look at [https://github.com/rails/rails/tree/master/actioncable]() for a good
  introduction.  (You won't be able to solve this exercise without some API info.)
