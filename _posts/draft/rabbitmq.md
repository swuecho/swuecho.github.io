



<p>RabbitMQ quickstart
</p>
<p>
</p>
<pre>
<code>root@temp:/# /usr/bin/amqp-publish --url=$BROKER_URL -r foo -p -b Hello
root@temp:/# /usr/bin/amqp-publish --url=$BROKER_URL -r foo -p -b Hello
root@temp:/# /usr/bin/amqp-consume --url=$BROKER_URL -q job1 -c 1 cat && echo
banana
root@temp:/# /usr/bin/amqp-consume --url=$BROKER_URL -q job1 -c 1 cat && echo
cherry
root@temp:/# /usr/bin/amqp-declare-queue --url=$BROKER_URL -q job2  -d
job2
root@temp:/# /usr/bin/amqp-delete-queue --url=$BROKER_URL -q job2  
0
root@temp:/# /usr/bin/amqp-delete-queue --url=$BROKER_URL -q job1  
5
root@temp:/# /usr/bin/amqp-delete-queue --url=$BROKER_URL -q job 
0</code>
</pre>
<p>
</p>




rabbitmq amqp.topic, where message go?

message disappear if no client exists.

[https://stackoverflow.com/questions/6148381/rabbitmq-persistent-message-with-topic-exchange](https://stackoverflow.com/questions/6148381/rabbitmq-persistent-message-with-topic-exchange)

*You need a durable queue to store messages if there are no connected consumers available to process the messages at the time they are published.*

*An exchange doesn't store messages, but a queue can. The confusing part is that exchanges can be marked as "durable" but all that really means is that the exchange itself will still be there if you restart your broker, but it does ****not**** mean that any messages sent to that exchange are automatically * ***persisted*** *.*
