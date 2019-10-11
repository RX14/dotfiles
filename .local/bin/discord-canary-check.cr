#!/usr/bin/crystal

def pkgbuild_version
  version = `curl -sSL 'https://aur.archlinux.org/rpc/?v=5&type=info&arg[]=discord-canary' | jq -r '.results[0].Version'`.strip
  version, _, pkgrel = version.partition('-')
  version
end

last_notification = pkgbuild_version

loop do
  current_version = `curl -sSL https://discordapp.com/api/v7/updates/canary\?platform\=linux | jq -r .name`.strip
  if pkgbuild_version != current_version && last_notification != current_version
    `notify-send -u critical "Discord Canary Update" "#{current_version}"`
    last_notification = current_version
  end

  sleep 60.seconds
rescue
  sleep 60.seconds
end
