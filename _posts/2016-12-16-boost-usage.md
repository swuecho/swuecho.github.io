---
layout: post
title:  boost usage 
date:   2016-12-16 22:07 
categories: tech 
---
because boost header is installed to 

```
/usr/include/boost
```

so you can comple this progrom

```cpp
#include <iostream>
#include <boost/array.hpp>

using namespace std;
int main(){
  boost::array<int, 4> arr = {{1,2,3,4}};
  cout << "hi" << arr[0];
  return 0;
}
```

for the library which is not header only, it is a bit tricky.


```cpp
#include <boost/filesystem.hpp>
#include <iostream>

using namespace boost::filesystem;

int main()
{
  path p("/home/echo/.zshrc");
  boost::system::error_code ec;
  boost::uintmax_t filesize = file_size(p, ec);
  if (!ec)
    std::cout << filesize << '\n';
  else
    std::cout << ec << '\n';
}
```

have to compile with

```bash
g++ file_size.cpp -o file_size -std=c++11   -lboost_system -lboost_filesystem  

```

the following does not work

```bash
g++ -std=c++11   -lboost_system -lboost_filesystem  file_size.cpp -o file_size
```

the reason? the order of -l matters.

http://stackoverflow.com/questions/11893996/why-does-the-order-of-l-option-in-gcc-matter
