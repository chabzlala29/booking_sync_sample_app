# BookingSync Sample App for Rentals
A sample BookingSync App integration just showing the Rentals of current account logged in.

[![Build Status](https://travis-ci.org/chabzlala29/booking_sync_sample_app.svg?branch=master)](https://travis-ci.org/chabzlala29/booking_sync_sample_app)
[![Code Climate](https://codeclimate.com/github/chabzlala29/booking_sync_sample_app/badges/gpa.svg)](https://codeclimate.com/github/chabzlala29/booking_sync_sample_app)
[![Issue Count](https://codeclimate.com/github/chabzlala29/booking_sync_sample_app/badges/issue_count.svg)](https://codeclimate.com/github/chabzlala29/booking_sync_sample_app)

## Preparing Development Environment

Install gem dependencies.
```
bundle install
```

Copy database.example.yml to database.yml same with secrets.example.yml to secrets.yml


## Setting up Environment Variables

The app uses dotenvrails gem so just create **.env** file and provide the following values

```
BOOKINGSYNC_URL=https://yourwebsite.com
BOOKINGSYNC_APP_ID=bookingsyncappid
BOOKINGSYNC_APP_SECRET=bookingsyncappsecret
BOOKINGSYNC_VERIFY_SSL=false
BOOKINGSYNC_SCOPE=rentals_read
```

## Running the server on Development

You just need to run it via thin server with SSL enabled
```
thin start -p 3000 --ssl
```
