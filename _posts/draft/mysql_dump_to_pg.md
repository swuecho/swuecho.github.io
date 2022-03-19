<h2>docker-compose
</h2>
<p>version: '3.1'
</p>
<p>services:
</p>
<p>  db:
</p>
<p>    image: mysql
</p>
<p>    restart: always
</p>
<p>    command: --default-authentication-plugin=mysql
  <em>native</em>password
</p>
<p>    environment:
</p>
<p>      MYSQL
  <em>ROOT</em>PASSWORD: root
</p>
<p>      MYSQL
  <em>DATABASE: test</em>db
</p>
<p>    ports:
</p>
<p>      - "3307:3306"
</p>
<p>    volumes:
</p>
<p>      - ./area
  <em>code</em>2020.sql:/area
  <em>code</em>2020.sql
</p>
<h2>connect to mysql in docker
</h2>
<pre>
<code>mysql -h 127.0.0.1 -P 3307 -u root -p test_db</code>
</pre>
<p>
</p>
<h2>import dump to mysql 
</h2>
<pre>
<code>mysql -h 127.0.0.1 -P 3307 -u root -p test_db < areacode2020.sql</code>
</pre>
<p>
</p>
<p>
</p>
<h2>create county table
</h2>
<p>
</p>
<p>CREATE VIEW area_index_2020 AS
  SELECT a.code,e.name AS province,d.name AS city  ,c.name AS county,b.name AS town,a.name AS villagetr
  FROM area_code_2020 a
  JOIN area_code_2020 b ON a.level=5 AND b.level=4 AND a.pcode=b.code
  JOIN area_code_2020 c ON b.pcode=c.code
  JOIN area_code_2020 d ON c.pcode=d.code
  JOIN area_code_2020 e ON d.pcode=e.code
  ORDER BY a.code
</p>
<p>
</p>
<p>
</p>
<p>CREATE table area_county_2020 AS  
</p>
<p> SELECT a.code,c.name AS province,b.name AS city ,a.name AS county
</p>
<p> FROM area_code_2020 a     
</p>
<p>JOIN area_code_2020 b ON a.level=3 AND b.level=2 AND a.pcode=b.code     
</p>
<p>JOIN area_code_2020 c ON b.pcode=c.code       
</p>
<p>ORDER BY a.code
</p>
<p>
</p>
<pre>
<code>CREATE table area_county_2020 AS  
SELECT a.code, b.name AS province , a.name AS city
FROM area_code_2020 a     
JOIN area_code_2020 b ON a.level=2 AND b.level=1 AND a.pcode=b.code     
ORDER BY a.code
</code>
</pre>
<pre>
<code>CREATE table areacounty2020 AS    </code>
</pre>
<p> SELECT a.code, b.name AS province ,a.name AS city
</p>
<p> FROM area_
  <em>code_</em>2020 a     
</p>
<p>JOIN area
  <em>code</em>2020 b ON a.level=3 AND b.level=2 AND a.pcode=b.code     
</p>
<p>JOIN area
  <em>code</em>2020 c ON b.pcode=c.code       
</p>
<p>ORDER BY a.code
</p>
<h1>export to csv from mysql
</h1>
<p>
</p>
<h2>pgloader  from mysql to postgres
</h2>
<p>
</p>
<p>
</p>
<p>
</p>
<p>➜  ~ curl 
  <a href="https://www.bestqa.net/go/get" target="_blank" ref="nofollow noopener noreferrer">https://www.bestqa.net/go/get</a>
  <em>row\?survey</em>name\=bestqa
  <em>demo</em>auth\&excel
  <em>name\=china</em>area_code.xlsx\&key\=id\&value\=2
</p>
<p>{"id": 2, "city": "市辖区", "code": 110102000000, "county": "西城区", "province": "北京市"}%
</p>
<p>
</p>
