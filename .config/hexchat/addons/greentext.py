#!/usr/bin/python
# -*- coding: utf-8 -*-

# Python 3.3
# HexChat 2.9.6

__module_name__ = 'GreenText'
__module_version__ = '1.0'
__module_description__ = ''

import hexchat

hexchat.prnt('GreenText script loaded')

def greentext_callback_incoming(word, word_eol, user_data):
    word = [word[i] if len(word) > i else '' for i in range(4)]

    if word[1][0] == '>':
        hexchat.emit_print(user_data, word[0], '\003' + '09' + word[1], word[2], word[3])
        return hexchat.EAT_ALL

    return hexchat.EAT_NONE

hexchat.hook_print('Channel Message', greentext_callback_incoming, 'Channel Message')
hexchat.hook_print('Your Message', greentext_callback_incoming, 'Your Message')

def greentext_callback_outgoing(w, we, userdata):
    if(we[0][0:1] == ">"):
        hexchat.command("say \003" + "09" + we[0])
        return hexchat.EAT_ALL

hexchat.hook_command("", greentext_callback_outgoing)
