---
layout: post
title:  pg queue using skip locked
date:   2024-06-17 02:15
categories: tech 
---

This is a note for myself that find in hacknews
https://news.ycombinator.com/item?id=20020501

```py
    import psycopg2
    import psycopg2.extras
    import random
    
    db_params = {
        'database': 'jobs',
        'user': 'jobsuser',
        'password': 'superSecret',
        'host': '127.0.0.1',
        'port': '5432',
    }
    
    conn = psycopg2.connect(**db_params)
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    
    def do_some_work(job_data):
        if random.choice([True, False]):
            print('do_some_work FAILED')
            raise Exception
        else:
            print('do_some_work SUCCESS')
    
    def process_job():
    
        sql = """DELETE FROM message_queue 
    WHERE id = (
      SELECT id
      FROM message_queue
      WHERE status = 'new'
      ORDER BY created ASC 
      FOR UPDATE SKIP LOCKED
      LIMIT 1
    )
    RETURNING *;
    """
        cur.execute(sql)
        queue_item = cur.fetchone()
        print('message_queue says to process job id: ', queue_item['target_id'])
        sql = """SELECT * FROM jobs WHERE id =%s AND status='new_waiting' AND attempts <= 3 FOR UPDATE;"""
        cur.execute(sql, (queue_item['target_id'],))
        job_data = cur.fetchone()
        if job_data:
            try:
                do_some_work(job_data)
                sql = """UPDATE jobs SET status = 'complete' WHERE id =%s;"""
                cur.execute(sql, (queue_item['target_id'],))
            except Exception as e:
                sql = """UPDATE jobs SET status = 'failed', attempts = attempts + 1 WHERE id =%s;"""
                # if we want the job to run again, insert a new item to the message queue with this job id
                cur.execute(sql, (queue_item['target_id'],))
        else:
            print('no job found, did not get job id: ', queue_item['target_id'])
        conn.commit()
    
    process_job()
    cur.close()
    conn.close()
```

## what is skip locked?

https://www.cybertec-postgresql.com/en/skip-locked-one-of-my-favorite-9-5-features/

As you can see, the second row has been excluded because it is already locked. Note that the second user is NOT blocked - it can proceed concurrently. This is highly important because transactions can co-exist nicely.

## a detailed version

https://vladmihalcea.com/database-job-queue-skip-locked/