[![Build Status](https://travis-ci.org/Habu-Kagumba/bawa.svg?branch=develop)](https://travis-ci.org/Habu-Kagumba/bawa)
[![Coverage Status](https://coveralls.io/repos/github/andela-hkagumba/bawa/badge.svg?branch=develop)](https://coveralls.io/github/andela-hkagumba/bawa?branch=develop)
[![Code Climate](https://codeclimate.com/github/andela-hkagumba/bawa/badges/gpa.svg)](https://codeclimate.com/github/andela-hkagumba/bawa)

# Bawa

[![Bawa](http://cdn.kagumba.com/assets/bawa.svg)](https://bawa.herokuapp.com)

![](http://cdn.kagumba.com/assets/homepage_search.png)

A flight booking application. __Providing a secure and reliable way to book for flights.__

# Description

Flight Management System that enables users to search for available flights and book for them.

You can access the online application here [bawa.herokuapp.com](https://bawa.herokuapp.com)

# Features

Your can book a flight by visiting the [homepage](https://bawa.herokuapp.com) and entering the origin, location, departure date and how many passengers you are booking for.
Registered users will recieve an email confirmation their booking and have the chance to view all their past bookings.

# Dependencies

|        Backend                 |  Front-end                     |  Testing/Development
|--------------------------------|--------------------------------|------------------------------------------------------------
| Rails Framework                |   Bourbon + Susy + Breakpoint  | RSpec + Factory Girl + Faker + Shoulda Matchers + SimpelCov
| PostgreSQL                     |   jQuery                       | Capybara + Poltergeist
| Figaro                         |   Typeahead                    | Letter Opener
| Puma server                    |                                | Guard

# Running the application

### Install dependencies

You need to install the following:

1. [Ruby](https://github.com/rbenv/rbenv)
2. [PostgreSQL](http://www.postgresql.org/download/macosx/)
3. [Bundler](http://bundler.io/)
4. [Rails](http://guides.rubyonrails.org/getting_started.html#installing-rails)
5. [RSpec](http://rspec.info/)

### Clone the repository

Clone the application to your local machine:

```
$ git clone https://github.com/Habu-Kagumba/bawa.git
```

Install the dependencies

```
$ bundle install
```

Setup database and seed data

```
$ rake db:setup
```

To run the application;

```
$ rails s
```
Now visit `http://localhost:3000` to view the application on your prefered web browser.

### Bonus development features

To enable `livereload` and auto re-run of the tests, run in your console;

```
$ guard
```

# Testing

You'll have to install some more dependencies:

1. [Poltergeist and PhantomJS](https://github.com/teampoltergeist/poltergeist#installation)

To run the tests, run
```
$ rspec spec
```

### Limitations

- Booking for flight through Paypal
- Cancelling flights
