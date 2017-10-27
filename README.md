# EventCalendar

[![Build Status](https://semaphoreci.com/api/v1/wowonrails/event_calendar/branches/master/shields_badge.svg)](https://semaphoreci.com/wowonrails/event_calendar)
[![Maintainability](https://api.codeclimate.com/v1/badges/1cf846afa985567d64ab/maintainability)](https://codeclimate.com/github/wowonrails/event_calendar/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/1cf846afa985567d64ab/test_coverage)](https://codeclimate.com/github/wowonrails/event_calendar/test_coverage)

## Project description

Web-application allows you to create personal private and public events, follow up other users and view them public events (https://github.com/wowonrails/event_calendar)

Based on https://github.com/fs/rails-base

## Quick Start

```bash
# clone repo
git@github.com:wowonrails/event_calendar.git
cd event_calendar

# run setup script
bin/setup

# configure ENV variables in .env
vim .env

# run server on 5000 port
bin/server
```

## Scripts

* `bin/setup` - setup required gems and migrate db if needed
* `bin/quality` - run brakeman and rails_best_practices for the app
* `bin/ci` - should be used in the CI to run specs

## Production

* https://event-calendar-wowaonrails.herokuapp.com/
