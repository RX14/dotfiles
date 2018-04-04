# Python 3.3
# HexChat 2.9.6

import hexchat

__module_name__ = "ZNC Buffextras"
__module_version__ = "1.2"
__module_description__ = "Displays the *buffextra lines from ZNC Buffextra " \
    "module nicely. Python implementation."
hexchat.emit_print("Generic Message", "Loading", "{} {} - {}".format(
                   __module_name__, __module_version__,
                   __module_description__))


def privmsg(word, word_eol, userdata, attrs):

    def send(*args, **kwargs):
        if attrs.time:
            kwargs.setdefault("time", attrs.time)
        return hexchat.emit_print(*args, **kwargs)

    bprefix = word[0]
    if bprefix[0:1] != ':':
        return hexchat.EAT_NONE

    bprefix = bprefix[1:]
    bnick, _, bhost = split_prefix(bprefix)

    if bnick == '*buffextras':
        channel = word[2]
        prefix = word[3][1:]
        _type = word[4]
        args = word_eol[5] if word[5:] else ''

        if '!' in prefix:
            nick, userhost = prefix.split('!')
        else:
            nick, userhost = prefix, None

        if _type == 'set':
            # :nick!ident@host set mode: +v other_nick
            send("Raw Modes", nick, "{} {}".format(channel, args[6:]))
        elif _type == 'joined':
            # :nick!ident@host joined
            send("Join", nick, channel, userhost)
        elif _type == 'parted':
            if args.startswith('with message: ['):
                # :nick!ident@host parted with message: [bla bla]
                send("Part with Reason", nick, userhost, channel,
                     args[15:-1])
            else:
                # :nick!ident@host parted
                send("Part", nick, userhost, channel)
        elif _type == 'is':
            # :nick!ident@host is now known as new_nick
            send("Change Nick", nick, args[13:])
        elif _type == 'quit':
            # :nick!ident@host quit with message: [Quit: Leaving.]
            send("Quit", nick, args[15:-1], userhost)
        elif _type == 'kicked':
            send("Kick", nick, word[5], channel,
                 word_eol[6][9:-1])
        elif _type == 'changed':
            send("Topic Change", nick, args[14:], channel)
        else:
            send("Server Error", "Unhandled *buffextras event:")
            send("Server Error",
                 "    {}".format(word_eol[3][1:]))
        return hexchat.EAT_ALL

    return hexchat.EAT_NONE


# extra tools
def split_prefix(prefix):

    if '!' in prefix:
        nick, _, userhostpart = prefix.partition('!')
        user, _, host = userhostpart.partition('@')
    else:
        nick, _, host = prefix.partition('@')
        user = ''

    return (nick, user, host)


hexchat.hook_server_attrs('PRIVMSG', privmsg, priority=hexchat.PRI_HIGHEST)
