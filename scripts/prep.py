import json
import re
import traceback
import sys

regex = re.compile('!!REPLACE!!(.+?)!!REPLACE!!')
file = open('dmp.json','r')
mapping = json.loads(file.read())
file.close()
for fname in mapping.keys():
  try:
    f = open(fname,'r')
    content = f.read()
    f.close()
    f = open(fname,'w')
    result = content
    for url in regex.finditer(content):
        result = result.replace(url.group(0),'#'+mapping[url.group(1).replace('html','md')])
    f.write(result)
    f.close()
  except Exception as e:
    print('failed processing',fname,file=sys.stderr)
    print(traceback.format_exc(),file=sys.stderr)