'''

@Created on March 1, 2018
@author: Tamer
'''
import json
import sys,os
from pymongo import MongoClient
if len(sys.argv) != 3:
    print "Usage : python upload_json.py <JSON file> <DB NAME>"
    sys.exit()
#try to load data
try:
    data = json.load(file(sys.argv[1]))
except:
    print "Couldn't retrieve the data!"
    sys.exit()
data = data["bug_status"]

count = 0
data_tmp = {}

client = MongoClient('localhost', 27017)
db = client.test_database
db = client[sys.argv[2]]
try:
    posts = db.posts
    for i in data:
            post_id = posts.insert_one({"b_id": i,"value": data[i]})
except:
    print "Failed to upload the data!"
