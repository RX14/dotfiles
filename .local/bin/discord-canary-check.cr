#!/usr/bin/crystal

require "semantic_version"
require "http"

last_notification = 0

loop do
  version = `curl -sSL 'https://aur.archlinux.org/rpc/?v=5&type=info&arg[]=discord-canary' | jq -r '.results[0].Version'`.strip
  version, _, pkgrel = version.partition('-')
  patch = SemanticVersion.parse(version).patch

  next_patch = patch + 1
  next_url = "https://dl-canary.discordapp.net/apps/linux/0.0.#{next_patch}/discord-canary-0.0.#{next_patch}.tar.gz"

  response = HTTP::Client.head(next_url)
  if response.status.ok? && last_notification != next_patch
    `notify-send -u critical "Discord Canary Update" "0.0.#{next_patch}"`
    last_notification = next_patch
  end

  sleep 60.seconds
end
