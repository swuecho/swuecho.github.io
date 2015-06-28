---
layout: post
title:  Scons Tutorial 
date:   2015-06-27 22:29 
categories: tech 
---
## what is scons?

it is auto build system. you can think it as an advanced verion of MAKE

suppose we have a C sourc code file, we want to complie it use scons,
with

    scons

and clean use

    scons -c

### Complie a program

create a file named SConstruct, add one line

    Program('4-3.c')

### Custom Env

change the content to, in order to custom the env

    env=Environment()
    env.Append(CCFLAGS = ['-std=c99', '-Wall', '-g'])
    env.Program('4-3.c')

### put the excuete program in a seperate fold ./build

move the source code to ./src folder

change the content of SConstruct to:

    env=Environment()
    env.Append(CCFLAGS = ['-std=c99', '-Wall', '-g'])
    env.SConscript('src/SConscript', variant_dir='build')

create a new file named SConscript with:

    env=Environment()
    env.Append(CCFLAGS = ['-std=c99', '-Wall', '-g'])
    env.Program('4-3.c')

### add more program

The advantage of scons is easy to add more program.
if you want to add another program and the src file name is 4-4.c
add a extra line to SConscript 

    env.Program('4-4.c')

and run <code>scons</code> 
