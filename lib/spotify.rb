class Spotify
  def self.current_track
    commands = [
      'set theTrack to current track',
      'set theArtist to artist of theTrack',
      'set theName to name of theTrack',
      'return theArtist & " - " & theName'
    ]
    spotify_command(commands)
  end

  def self.skip_track
    spotify_command("next track")
  end

  private

  def self.spotify_command(commands)
    commands = [commands] unless commands.is_a? Array
    commands.unshift 'tell application "Spotify"'
    commands.push    'end tell'
    commands.map! { |c| "-e '#{c}'" }

    `osascript #{commands.join ' '}`
  end
end
