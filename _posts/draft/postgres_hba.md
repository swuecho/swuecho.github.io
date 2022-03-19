<p>
</p>
<p>
</p>
<pre>
<code>hwu@rock:~$ sudo -u postgres createuser --interactive
Enter name of role to add: hwu
Shall the new role be a superuser? (y/n) y
hwu@rock:~$ sudo -u postgres createdb hwu
hwu@rock:~$ sudo -u hwu psql
psql (12.2 (Ubuntu 12.2-4))
Type "help" for help.
hwu=# \password hwu
Enter new password:
Enter it again:
</code>
</pre>
<p>
</p>
<pre>
<code>hwu@stock:~$ cat postgres.sh 
hwu@rock:/etc/postgresql/12/main$ ls -lah
total 64K
drwxr-xr-x 3 postgres postgres 4.0K Jun 16 13:35 .
drwxr-xr-x 3 postgres postgres 4.0K Jun 15 21:57 ..
drwxr-xr-x 2 postgres postgres 4.0K Jun 15 21:57 conf.d
-rw-r--r-- 1 postgres postgres  315 Jun 15 21:57 environment
-rw-r--r-- 1 postgres postgres  143 Jun 15 21:57 pg_ctl.conf
-rw-r----- 1 postgres postgres 4.8K Jun 16 13:35 pg_hba.conf
-rw-r----- 1 postgres postgres 1.6K Jun 15 21:57 pg_ident.conf
-rw-r--r-- 1 postgres postgres  27K Jun 16 13:34 postgresql.conf
-rw-r--r-- 1 postgres postgres  317 Jun 15 21:57 start.conf
hwu@rock:/etc/postgresql/12/main$
postgresql.conf
```
listen_addresses = 'localhost'
to 
listen_addresses = '*'
```
pg_hba.conf
```
host    all             all              0.0.0.0/0                       md5
host    all             all              ::/0                            md5
```</code>
</pre>
<p>
</p>
<p>
</p>
<p>
</p>
<p>
</p>
