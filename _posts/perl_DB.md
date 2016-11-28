Perl DB notes
===========

# do, execute, prepare

if you want to execute an SQL statement once and do not care about the return value

```perl
$dbh->do($sql);
```

if you want to execute an SQL statement many times,

```perl
my $sth = $dbh->prepare($insert_sql);

foreach my $value (@value) {
    $sth->execute($values);
}

```

for retrieving data, however, you have several options. One of the most
common is to prepare the SQL, execute it, and repeatly fetch the results.

there are many ways to fetch the results, depending on your needs.

Methods are available that allow you to skip the iterator and return all your data at one time. These methods are generally called agaist the database handle and prepare, execute and fetch your data all in one go.

```perl
my $result = $dbh->selectall_arrayref($sql);
```
selectall_* methods are good for select small amounts of data. If your SQL statement return a huge amount of data, try to avoid it.

