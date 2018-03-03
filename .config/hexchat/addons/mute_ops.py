import hexchat

__module_name__ = "Op Silencer"
__module_author__ = "RX14"
__module_version__ = "0.0.1"
__module_description__ = "Hide Op in certain channels"

def op_cb(word, word_eol, userdata):
    if ("fc00.io" in hexchat.get_info("network")) and (hexchat.get_info("channel") == "#cjdns"):
        return hexchat.EAT_ALL
    else:
        return hexchat.EAT_NONE

if __name__ == '__main__':
    hexchat.hook_print("Channel Operator", op_cb)
    print(__module_name__, __module_version__, "loaded")
