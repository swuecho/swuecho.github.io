---
layout: post
title:  Tiny C Compiler 
date:   2016-12-02 14:19 
categories: tech 
---

## install tcc.

downlaod Tiny C first from the homepage and then 

```
./configure
make 
make test
sudo make install
```

## shebang approach

after that you can use as an 'interpreted' language
and write c 'script'

```c
#!/usr/local/bin/tcc -run
#include <stdio.h>
double circlarArea( double r);


int main() {
	double radius = 1.0, area = 0.0;
	area = circlarArea(radius);
	printf("        Area of Cirlces \n\n");
	printf("        Radius    area\n");
	printf("     -------------------\n");
	printf("%10.1f  %10.2f\n", radius, area);
	radius = 5.0;
	area = circlarArea(radius);
	printf("%10.1f  %10.2f\n", radius, area);
	return 0;
}



double circlarArea(double r ) {

	const double pi = 3.1415926536;
	return pi * r * r;
}
```

then

```
chmod +x circle_run.c
```

```bash
➜  ✗ ./circle_run.c
        Area of Cirlces

        Radius    area
     -------------------
       1.0        3.14
       5.0       78.54
➜  ✗
```

## use 'tcc -run'

```c
#include <stdio.h>
double circlarArea( double r);


int main() {
	double radius = 1.0, area = 0.0;
	area = circlarArea(radius);
	printf("        Area of Cirlces \n\n");
	printf("        Radius    area\n");
	printf("     -------------------\n");
	printf("%10.1f  %10.2f\n", radius, area);
	radius = 5.0;
	area = circlarArea(radius);
	printf("%10.1f  %10.2f\n", radius, area);
	return 0;
}



double circlarArea(double r ) {

	const double pi = 3.1415926536;
	return pi * r * r;
}
```
save the above file as 'circle.c'

```c
tcc -run circle.c
➜  c_in_nutshell git:(master) ✗ tcc -run circle.c
        Area of Cirlces

        Radius    area
     -------------------
       1.0        3.14
       5.0       78.54
```

## conclusion

I think I really like the 'tcc -run'. really regret that I did not find it earlier. I will make learn C easier.

probably, I should be able to write a wrapper around the gcc to have the same function.

