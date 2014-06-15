from celery import Celery
from db import get_conn
from email import message_from_string

app = Celery('mail', broker='redis://localhost:6379/0')

@app.task
def process(id):
	conn = get_conn()
	cur = conn.cursor()
	cur.execute('select recipient, body, date from drop where id = %s', (id, ))
	row = cur.fetchone()

	rcpt = row[0]
	msg = message_from_string(row[1])
	date = row[2]

	cur.execute("select m.id as member_id, a.id as alias_id from alias a inner join member m on (a.member_id = m.id) inner join domain d on (a.domain_id = d.id) where (a.name || '@' || d.name) = %s", (rcpt, ))
	row = cur.fetchone()

	member_id = row[0]
	alias_id = row[1]

	subject = msg['Subject']
	body = str(msg.get_payload(0))

	# print member_id, date, alias_id, subject, body

	cur.execute('insert into message ( member_id, date, alias_id, subject, body ) values ( %s, %s, %s, %s, %s ) returning ( id )', (member_id, date, alias_id, subject, body))

	row = cur.fetchone()
	message_id = row[0]

	cur.execute('update drop set processed = true where id = %s', (id, ))

	conn.commit()

	cur.close()
	conn.close()

	return (id, message_id)

if __name__ == '__main__':
	process(13)
