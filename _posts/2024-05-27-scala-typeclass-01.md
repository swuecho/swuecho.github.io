---
layout: post
title:  scala typeclass 01 -- Create new Instance of typeclass (Ordering)
date:   2024-05-27 19:07 
categories: tech 
---


## create instance of Ordering Typeclass

```scala
case class MyInt(value: Int)

// instance of Ordering
object MyIntOrdering extends Ordering[MyInt] {
  def compare(x: MyInt, y: MyInt): Int =
    if x.value < y.value then -1 else if x.value > y.value then 1 else 0
}

def main(args: Array[String]): Unit = {
  val mInt4 = MyInt(4)
  val mInt5 = MyInt(5)
  print(MyIntOrdering.compare(mInt4, mInt5))
}
```

## given and summon

```scala
case class MyInt(value: Int) 

object MyIntOrdering extends Ordering[MyInt] {
  def compare(x: MyInt, y: MyInt): Int =
    if x.value < y.value then -1 else if x.value > y.value then 1 else 0
}

given Ordering[MyInt] = MyIntOrdering

def main(args: Array[String]): Unit = {
  val mInt4 = MyInt(4)
  val mInt5 = MyInt(5)
  val myIntOrdering = summon[Ordering[MyInt]]
  print(myIntOrdering.compare(mInt4, mInt5)) // summon[Ordering[MyInt]])
}
```

## combine given and typeclass instance definition

```scala
case class MyInt(value: Int) 

given Ordering[MyInt] with {
  def compare(x: MyInt, y: MyInt): Int =
    if x.value < y.value then -1 else if x.value > y.value then 1 else 0
}

def main(args: Array[String]): Unit = {
  val mInt4 = MyInt(4)
  val mInt5 = MyInt(5)
  val myIntOrdering = summon[Ordering[MyInt]]
  println(myIntOrdering.compare(mInt4, mInt5)) // summon[Ordering[MyInt]])
}
```

## extension method

```scala
case class MyInt(value: Int) 

given Ordering[MyInt] with {
  def compare(x: MyInt, y: MyInt): Int =
    if x.value < y.value then -1 else if x.value > y.value then 1 else 0
}

extension (x: MyInt)
  def compare(y: MyInt)(using ord: Ordering[MyInt]): Int =
    ord.compare(x, y)

def main(args: Array[String]): Unit = {
  val mInt4 = MyInt(4)
  val mInt5 = MyInt(5)
  val myIntOrdering = summon[Ordering[MyInt]]
  println(mInt4.compare(mInt5))
}
```
