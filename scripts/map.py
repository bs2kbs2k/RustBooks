import json
import time
import re
import traceback
import sys

fnames = input().split(' ')
mydict = {}
for fname in fnames:
  try:
    f = open(fname.strip(' '),'r')
    stripped = f.readline().strip('# \n')
    lowered =stripped.lower()
    mydict[fname.strip(' ')] = re.sub(r'[^a-z\-]+', '', lowered.replace(' ', '-'))
    f.close()
  except Exception as e:
    print('failed opening',fname,file=sys.stderr)
    print(traceback.format_exc(),file=sys.stderr)

t = str(int(time.time()))
f = open('dump'+t+'.json','w')
f.write(json.dumps(mydict))
f.close()
print('filename:','dump'+t+'.json',file=sys.stderr)
print('dump'+t+'.json')
