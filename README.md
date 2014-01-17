# Votify

## What?

Sick of crap music on the office Spotify playlist? Then vote and ye shall be liberated!

## I'm sold. How?

Take the following steps on the machine running Spotify:

### First time setup:

1. Clone the rep
2. Edit the `.env` file, filling in a proxylocal subdomain of your choice and Google API credentials from https://code.google.com/apis/console (if you work at Alliants, just ask me for mine.)
3. Run `bundle install`
4. Change `VOTERS_REQUIRED_TO_SKIP` and `EMAIL_REGEXP` in `votify.rb` to suit your needs.

### Run her:

1. `foreman start`
2. Encourage colleagues with good taste to visit `HOST.t.proxylocal.com` (where `HOST` is the value from `.env`)

## Warning

This is very beta and might not work that well. Pull Requests are most welcome!