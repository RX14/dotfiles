__module_name__ = "Bridge Bot Integration"
__module_version__ = "1.11R"
__module_description__ = "Integrates messages from IRC Bridge Bots - Vex Edition"
__author__ = "Michiyo, gamax92, Vexatos"

import hexchat, re
hexchat.emit_print("Generic Message", "Loading", "{} {} - {}".format(
                   __module_name__, __module_version__,
                   __module_description__))


types = ["<>", "()", ":"]

ignorelist = {}
botlist = {}
typelist = {}

userlist = {}

def getusers(channel):
    return userlist.setdefault(channel, [])

def adduser(channel, user):
    users = getusers(channel)
    if user in users:
        users.insert(0, users.pop(users.index(user)))
    else:
        users.insert(0, user)
        #hexchat.command('RECV :{3}{0}!~{1}@bridgebot.py JOIN :{2}'.format(user, bot, channel, botprefix))

def loadlist():
    global ignorelist
    global botlist
    global typelist
    try:
        ignorelist = eval(hexchat.get_pluginpref('ignorelist'))
        botlist = eval(hexchat.get_pluginpref('botlist'))
        typelist = eval(hexchat.get_pluginpref('typelist'))
    except Exception as e:
        hexchat.prnt(str(e))

def savelist():
    global ignorelist
    global botlist
    global typelist
    ignorelist = list(filter(None, ignorelist))
    hexchat.set_pluginpref('ignorelist', str(ignorelist))
    hexchat.set_pluginpref('botlist', str(botlist))
    hexchat.set_pluginpref('typelist', str(typelist))
    loadlist()
    printlist()

def nested(x, ys):
    return any(x in nested for nested in ys)

def privmsg(word, word_eol, userdata, attrs):
    global ignorelist
    global botlist
    global typelist
    def send(*args, **kwargs):
        if attrs.time:
            kwargs.setdefault("time", attrs.time)
        return hexchat.emit_print(*args, **kwargs)

    bprefix = word[0]
    if bprefix[0:1] != ':':
        return hexchat.EAT_NONE

    bprefix = bprefix[1:]
    bnick, _, bhost = split_prefix(bprefix)
    for key in botlist:
        if bnick.lower() == key.lower():
            nicktype = ""
            if key in typelist:
                nicktype = typelist[key]
            channel = word[2]
            nick = hexchat.strip(word[3][1:])
            for iggynick in ignorelist:
                if re.search(iggynick.lower(), nick.lower().replace('\u200b', '')) is not None:
                    return hexchat.EAT_ALL
            if len(nick) <= 0:
                return hexchat.EAT_NONE
            if nick == '*':
                adduser(channel, hexchat.strip(word[4]))
                if check_highlight(word_eol[5] if len(word_eol) >= 6 else ""):
                    send("Channel Action Hilight", hexchat.strip(word[4]), word_eol[5] if len(word_eol) >= 6 else "", botlist[key])
                    hexchat.command('gui color 3')
                else:
                    send("Channel Action", hexchat.strip(word[4]), word_eol[5] if len(word_eol) >= 6 else "", botlist[key])
                    hexchat.command('gui color 2')
            elif nick[0] == '<' and (not nicktype or nicktype == "<>"):
                found = False
                if nick[-1] == '>':
                    found = True
                else:
                    while len(word) > 4:
                        nick += " " + hexchat.strip(word[4])
                        del word[4]
                        del word_eol[4]
                        if nick[-1] == '>':
                            found = True
                            break
                if not found:
                    return hexchat.EAT_NONE
                adduser(channel, nick[1:-1])
                if check_highlight(word_eol[4] if len(word_eol) >= 5 else ""):
                    send("Channel Msg Hilight", nick[1:-1], word_eol[4] if len(word_eol) >= 5 else "", botlist[key])
                    hexchat.command('gui color 3')
                else:
                    send("Channel Message", nick[1:-1], word_eol[4] if len(word_eol) >= 5 else "", botlist[key])
                    hexchat.command('gui color 2')
            elif nick[0] == '(' and (not nicktype or nicktype == "()"):
                found = False
                if nick[-1] == ')':
                    found = True
                else:
                    while len(word) > 4:
                        nick += " " + hexchat.strip(word[4])
                        del word[4]
                        del word_eol[4]
                        if nick[-1] == ')':
                            found = True
                            break
                if not found:
                    return hexchat.EAT_NONE
                adduser(channel, nick[1:-1])
                if check_highlight(word_eol[4] if len(word_eol) >= 5 else ""):
                    send("Channel Msg Hilight", nick[1:-1], word_eol[4] if len(word_eol) >= 5 else "", botlist[key])
                    hexchat.command('gui color 3')
                else:
                    send("Channel Message", nick[1:-1], word_eol[4] if len(word_eol) >= 5 else "", botlist[key])
                    hexchat.command('gui color 2')
            elif nicktype and nicktype != ":":
                return hexchat.EAT_NONE
            else:
                found = False
                if nick[-1] == ':':
                    found = True
                else:
                    while len(word) > 4:
                        nick += " " + hexchat.strip(word[4])
                        del word[4]
                        del word_eol[4]
                        if nick[-1] == ':':
                            found = True
                            break
                if not found:
                    return hexchat.EAT_NONE
                adduser(channel, nick[1:-1])
                if check_highlight(word_eol[4] if len(word_eol) >= 5 else ""):
                    send("Channel Msg Hilight", nick[:-1], word_eol[4] if len(word_eol) >= 5 else "", botlist[key])
                    hexchat.command('gui color 3')
                else:
                    send("Channel Message", nick[:-1], word_eol[4] if len(word_eol) >= 5 else "", botlist[key])
                    hexchat.command('gui color 2')
            return hexchat.EAT_HEXCHAT

    return hexchat.EAT_NONE

def check_highlight(message):
    hilights = hexchat.get_prefs("irc_extra_hilight")
    hilight_list = hilights.split(",")
    if hexchat.get_info("nick") in message:
        return True
    elif any(message.find(check) > -1 for check in hilight_list):
        return True
    else:
        return False

def split_prefix(prefix):
    if '!' in prefix:
        nick, _, userhostpart = prefix.partition('!')
        user, _, host = userhostpart.partition('@')
    else:
        nick, _, host = prefix.partition('@')
        user = ''
    return (nick, user, host)

def addignore(word, word_eol, userdata):
    global ignorelist
    ignorelist.append(word[1])
    hexchat.prnt("Added " + word[1] + " to your ignore list.")
    savelist()
    return hexchat.EAT_ALL

def addbot(word, word_eol, userdata):
    global botlist
    global typelist
    if len(word) < 3 or len(word) > 4 or (len(word) == 4 and not word[3] in types):
        hexchat.prnt("Syntax is /addbot botnick prefix [type]: /addbot Corded ^")
        hexchat.prnt("Types are: <> () :")
        return hexchat.EAT_ALL
    botlist.update({word[1]:word[2]})
    if len(word) == 4 and word[3] in types:
        typelist.update({word[1]:word[3]})
        hexchat.prnt("Added " + word[1] + " to your bot list with prefix " + word[2] + " at type " + word[3] + ".")
    else:
        hexchat.prnt("Added " + word[1] + " to your bot list with prefix " + word[2] + ".")
    savelist()
    return hexchat.EAT_ALL

def delbot(word, word_eol, userdata):
    global botlist
    global typelist
    try:
        botlist.pop(word[1], None)
        typelist.pop(word[1], None)
        hexchat.prnt("Removed " + word[1] + " from your bot list.")
        savelist()
    except: pass
    return hexchat.EAT_ALL

def delignore(word, word_eol, userdata):
    global ignorelist
    try:
        ignorelist.remove(word[1])
        hexchat.prnt("Removed " + word[1] + " from your ignore list.")
        savelist()
    except: pass
    return hexchat.EAT_ALL

def disignore(word, word_eol, userdata):
    printlist()
    return hexchat.EAT_ALL

def printlist():
    global ignorelist
    global botlist
    if len(ignorelist) == 0:
        hexchat.prnt('Ignorelist is empty')
    else:
        hexchat.prnt('Ignorelist: ' + ', '.join(ignorelist))
    if len(botlist) == 0:
        hexchat.prnt('Botlist is empty')
    else:
        hexchat.prnt('Bot List: ' + ', '.join("{!s}={!r}".format(key,val) for (key,val) in botlist.items()))

loadlist()
hexchat.hook_command("addignore", addignore)
hexchat.hook_command("delignore", delignore)
hexchat.hook_command("ignorelist", disignore)
hexchat.hook_command("addbot", addbot)
hexchat.hook_command("delbot", delbot)
hexchat.hook_server_attrs('PRIVMSG', privmsg)

# Stolen from https://github.com/MaurizioB/hexchat-gitter-nick-completion/blob/master/gitter-nick-completion.py
cx_list = {}
tracked_keys = ['65288', #backspace
                ]
ignored_keys = ['65307', #esc
]

def check_completion(word, word_eol, userdata):
    cx = hexchat.get_context()
    channel = [chan for chan in hexchat.get_list('channels') if chan.context==hexchat.get_context()][0]
    if channel.type == 2:
        inputstr = cx.get_info('inputbox')
        inputbox = inputstr.split()
        #nick = ""
        if word[0] == '65289' and len(inputbox) >= 1:
            chan = cx_list.get(cx.get_info('channel'))
            if chan:
                typed = chan['typed']
                cycle = chan['cycle']+1
                matching = chan['matching']
                if cycle == len(matching):
                    cycle = 0
                if not typed in inputbox:
                    if not [i for i in matching if "@" + i in inputbox]:
                        return hexchat.EAT_NONE
                    inputbox[chan['pos']] = typed
            else:
                #typed = inputbox[-1]
                wordend = hexchat.get_prefs("state_cursor")
                wordstart = inputstr[:wordend].rfind(' ') + 1
                #fullwordlength = inputstr[wordstart:].find(' ')
                #typed = inputstr[wordstart:wordstart+fullwordlength] if fullwordlength >= 0 else inputstr[wordstart:]
                typed = inputstr[wordstart:wordend]
                #print(typed, wordstart, wordend, len(typed))
                nickname = typed
                if nickname.startswith('@'):
                    nickname = nickname[1:]
                else:
                    return hexchat.EAT_NONE
                cycle = 0
                matching = []
                users = getusers(channel.channel)
                if hexchat.get_prefs("completion_sort") != 1:
                    users.sort()
                for nick in users:
                    if nick.lower().startswith(nickname.lower()):
                        matching.append(re.sub("[\u200b]", "", nick))
            if not len(matching):
                #empty list
                if cx_list.get(cx.get_info('channel')):
                    cx_list.pop(cx.get_info('channel'))
                return hexchat.EAT_NONE
            if not typed in inputbox:
                #print(inputbox)
                return hexchat.EAT_NONE
            inputindex = inputbox.index(typed)
            inputprev = inputbox[:inputindex]
            inputprev.append("@" + matching[cycle])
            #inputbox[inputindex] = inputbox[inputindex].replace(typed, "")
            #if not inputbox[inputindex]:
            #    del inputbox[inputindex]
            inputnext = inputbox[inputindex + 1:]
            prevtext = " ".join(inputprev)
            cx_list[cx.get_info('channel')] = {'typed': typed, 'matching': matching, 'cycle': cycle, 'pos': inputindex}
            #print(inputbox[inputindex], inputprev, inputnext)
            hexchat.command('SETTEXT {0} {1}'.format(prevtext, " ".join(inputnext)))
            hexchat.command('SETCURSOR {}'.format(len(prevtext) + 1))
            return hexchat.EAT_ALL
        #ignoring mod and "empty" keys, but let pass backspace to clear the context dictionary
        elif (not int(word[3]) and not word[0] in tracked_keys) or word[0] in ignored_keys:
            return hexchat.EAT_NONE
        else:
            #reset context for channel
            if cx_list.get(cx.get_info('channel')):
                cx_list.pop(cx.get_info('channel'))
            return hexchat.EAT_NONE
    else:
        return hexchat.EAT_NONE

hexchat.hook_print('Key Press', check_completion)

hexchat.prnt(__module_name__ + " " + __module_version__ + " loaded!")
printlist()
