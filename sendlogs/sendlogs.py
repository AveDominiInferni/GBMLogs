from pymongo import MongoClient
import os
import pathlib

cluster = MongoClient("mongodb+srv://Ajso:nkiatkkcrp2301@cluster01.oemmd.mongodb.net/logs?retryWrites=true&w=majority")
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
        else:
            print("Missing logs for %s" %filename)
input("Press Enter to exit.")
