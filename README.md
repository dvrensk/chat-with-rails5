# Chatting with Rails 5

This repo documents step by step how to build the chat application that [DHH creates
on the Rails homepage](http://rubyonrails.org/).

In the `exercise` branch you will find instructions for a small exercise that we are going
to do at a meeting for the Barcelona Ruby on Rails group.  In the `multi-room` branch you'll
find a sample solution.

## To install

```bash
git clone git@github.com:sequra/chat-with-rails5.git
cd chat-with-rails5
bundle install
bin/rails db:setup
```

You need Ruby 2.2.2 or newer and PostgreSQL 9.x (I have only tested with `x=4`).

## To run

There are no tests or specs.  To run the application, run `rails server` and open
a browser to [http://localhost:3000/]().
