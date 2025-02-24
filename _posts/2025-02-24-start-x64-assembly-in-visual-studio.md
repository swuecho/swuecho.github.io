---
layout: post
title:  start x64 assembly in visual studio
date:   2025-02-24 05:02
categories: tech 
---

# how to setup

## step 1: create a visual cpp project

![hello world](/assets/img/visual_studio_hello_world.png)

make sure cpp is running ok

## step 2: build customization

![build customization](/assets/img/visual_studio_build_customization.png)

![masm](/assets/img/visual_studio_build_customization_masm.png)

## step 3: change item type

Go to the assembly file, change the item type


![assmebler](/assets/img/visual_studio_asm_assembler.png)

# code example

foo.asm

```assembly
.code

foo PROC
	mov rax, 124
	ret
foo ENDP

END

```

```cpp
#include <iostream>

using namespace std;

extern "C" int foo();

int main() {
	cout << "the result is " << foo() << endl;

	cin.get();  // Wait for the user to press Enter
	return 0;
}

```