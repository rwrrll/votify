# Votify

## What?

Sick of crap music on the office Spotify playlist? Then vote and ye shall be liberated!

## I'm sold. How?

Take the following steps on the machine running Spotify:

### First time setup:

1. Clone the repo
2. Edit the `.env` file, filling in:
   - `HOST` with a proxylocal subdomain of your choice
   - Google API credentials from https://code.google.com/apis/console (if you work in my office, just ask me for mine.)
3. Run `bundle install`
4. Change `VOTERS_REQUIRED_TO_SKIP` and `EMAIL_REGEXP` in `votify.rb` to suit your needs.

### Run her:

1. `bundle exec foreman start`
2. Encourage colleagues with good taste to visit `http://HOST.t.proxylocal.com` (where `HOST` is the value from `.env`)

## Warning

- Uses AppleScript, so only works on OS X. Sorry. (I'm not sorry.)
- Very beta, so might not work that well. Pull Requests are most welcome!
