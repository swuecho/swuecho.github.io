---
layout: post
title:  install and using Boost 
date:   2016-01-08 21:07 
categories: tech 
---

export BOOST_ROOT and BOOST_PATH 

    ### BOOST
    export BOOST_ROOT=/path/to/unziped_boost
    export BOOST_VERSION=1.60.0

# install

    cd $BOOST_ROOT
    ./bootstrap.sh --show-libraries
    sudo ./b2 install


# use 




build static binary

    g++ -static -o /tmp/bft_stc boost_time.cpp -lboost_date_time  

build static binary

    c++ -I $BOOST_ROOT boost_regex_exmple.cpp -o example -lboost_regex
    g++  -o /tmp/bft_stc boost_time.cpp -lboost_date_time


cpp11

    c++ lambda.cpp --std=c++11 -o lambda


## TODO

write a simple make file with std=c++11 and boost

