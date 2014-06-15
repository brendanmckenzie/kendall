#!/usr/bin/python2.7

import sys, psycopg2
from tasks import process
from db import get_conn

# gather the information
recipient = sys.argv[1]
data = sys.stdin.read()

conn = get_conn()
cur = conn.cursor()

# insert it into the database
cur.execute("insert into drop ( date, processed, recipient, body ) values ( current_timestamp, 'N', %s, %s ) returning ( id )", (recipient, data))

ret = cur.fetchone()

# get the database id
id = ret[0]

conn.commit()

cur.close()
conn.close()

# send to the queue for processing
process.delay(id)

print 'delivered (%d).' % (id) 
