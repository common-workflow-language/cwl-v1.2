import json
import sys
j = json.load(open(sys.argv[1]))
json.dump({"class": j["class"],
           "basename": j["basename"]}, sys.stdout, sort_keys=True)
