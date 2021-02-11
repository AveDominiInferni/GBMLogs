from pymongo import MongoClient
from dhooks import Webhook
import os
import pathlib

prefix = "%"
cluster = MongoClient("mongodb+srv://Ajso:nkiatkkcrp2301@cluster01.oemmd.mongodb.net/logs?retryWrites=true&w=majority")
hook = Webhook("https://discord.com/api/webhooks/807024174878294017/hBgYyJOw-rPIjKYOCCKZhfwWVHAan_bsprf28oRTBWNaE_st9RdYRFC5BiNiSgwKq48D")

i = 0
db = cluster["rawlogs"]
logs_path = "\SavedVariables\GuildBankLogger.lua"
server_dir = str(pathlib.Path(__file__).parent.absolute())
for filename in os.listdir(server_dir):
    char_path = server_dir + "\\" + filename
    if os.path.isdir(char_path):
        path = char_path + logs_path
        if (os.path.isfile(path)):
            collection = db["rawlogs"]
            file = open(path, "r")
            collection.insert_one({"content": file.read()})
            print("Logs for %s have been uploaded" %filename)
            file.close()
            os.remove(path)
            i += 1

if (i == 0):
    print("No logs found")
    input("Press Enter to exit.")
else:
    input("Press Enter to exit.")
    hook.send(prefix + "update")