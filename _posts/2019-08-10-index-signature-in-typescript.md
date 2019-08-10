---
layout: post
title:  index signature in typescript 
date:   2019-08-10 12:11 
categories: tech 
---

## Index Signatures

read the code below.

```{typescrpt}
interface Foo {
    [index: string]: number
}

let foo: Foo = { x: 1, y: 2 };
console.log(foo['x']); // number
```

```{typescrpt}
interface Bar {
    [key: string]: number
}

let bar: Bar = { x: 1, y: 2 };
console.log(bar['x']); // number
```

```{typescrpt}
interface Baz {
    [random_name: string]: number
}

let baz: Baz = { x: 1, y: 2 };
console.log(baz['x']); // number
```

## [] indicates the index signature

all the three code snnippts are equal, since [] is the index signature and the name in it is unrelevent. this is similar to function signature
where the name of the parameter does not matter.



