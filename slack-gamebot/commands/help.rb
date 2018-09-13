module SlackGamebot
  module Commands
    class Help < SlackRubyBot::Commands::Base
      HELP = <<-EOS
I am your friendly Gamebot, here to help.

```
General
-------
hi: be nice, say hi to your bot
team: show your team's info and captains
register: register yourself as a player
help: get this helpful message
sucks: express some frustration

Games
-----
challenge <opponent>, ... [with <teammate>, ...]: challenge opponent(s) to a game
accept: accept a challenge
decline: decline a previous challenge
cancel: cancel a previous challenge
lost [to <opponent>] [score, ...]: record your loss
resigned [to <opponent>]: record a resignation
draw: record a tie

Stats
-----
leaderboard: show the top 3 players. (leaderboard # has been disabled to prevent channel spam.)
rank [<player> ...]: rank a player or a list of players
matches [number|infinity]: show this season's matches
season: show current season

Captains
--------
promote <player>: promote a user to captain
demote me: demote you from captain

Premium
-------
seasons: show all seasons
reset <team>: reset all stats, start a new season
set gifs [on|off]: enable/disable animated GIFs, default is on
set aliases [<alias|none> ...]: set additional bot aliases
set api [on|off]: enable/disable team data in the public API, default is off
```
        EOS
      def self.call(client, data, _match)
        client.say(channel: data.channel, text: [
          HELP,
          SlackGamebot::INFO,
          client.owner.reload.premium? ? nil : client.owner.upgrade_text
        ].compact.join("\n"))
        client.say(channel: data.channel, gif: 'help')
        logger.info "HELP: #{client.owner} - #{data.user}"
      end
    end
  end
end
