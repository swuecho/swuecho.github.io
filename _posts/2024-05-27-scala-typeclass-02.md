---
layout: post
title:  scala typeclass 02  -- create typeclass and instance
date:   2024-05-27 19:33 
categories: tech 
---

## create your own typeclass

```scala
// https://learnyouahaskell.com/making-our-own-types-and-typeclasses#typeclasses-102
//class YesNo a where
//    yesno :: a -> Bool

trait YesNo[A] {
  def yesno(a: A): Boolean
}


given YesNo[Int] = new YesNo[Int] {
  def yesno(a: Int): Boolean = a > 0
}

given YesNo[String] = new YesNo[String] {
  def yesno(a: String): Boolean = a.length > 0
}

given YesNoList[T]: YesNo[List[T]] = new YesNo[List[T]] {
  def yesno(a: List[T]): Boolean = a.length > 0
}

given YesNoOption[T]: YesNo[Option[T]] = new YesNo[Option[T]] {
  def yesno(a: Option[T]): Boolean = a.isDefined
}

case class MyInt(value: Int)

given YesNo[MyInt] = new YesNo[MyInt] {
  def yesno(a: MyInt): Boolean = a.value > 0
}

extension (a: MyInt) def yesno(using yesno: YesNo[MyInt]) = yesno.yesno(a)

def main(args: Array[String]): Unit = {
  val mInt4 = MyInt(4)
  val mInt5 = MyInt(5)
  println(mInt4.yesno)
  println(mInt5.yesno)
  val listYesNo = summon[YesNo[List[Int]]]
  println(listYesNo.yesno(List(1,2)))
}
```

## generic extension method

```scala
trait YesNo[A] {
  def yesno(a: A): Boolean
}

given YesNo[Int] = new YesNo[Int] {
  def yesno(a: Int): Boolean = a > 0
}

given YesNo[String] = new YesNo[String] {
  def yesno(a: String): Boolean = a.length > 0
}

given YesNoList[T]: YesNo[List[T]] = new YesNo[List[T]] {
  def yesno(a: List[T]): Boolean = a.length > 0
}

given YesNoOption[T]: YesNo[Option[T]] = new YesNo[Option[T]] {
  def yesno(a: Option[T]): Boolean = a.isDefined
}

case class MyInt(value: Int)

given YesNo[MyInt] = new YesNo[MyInt] {
  def yesno(a: MyInt): Boolean = a.value > 0
}

//extension (a: MyInt) def yesno(using yesno: YesNo[MyInt]) = yesno.yesno(a)
//extension[T] (a: List[T]) def yesno(using yesno: YesNo[List[T]]) = yesno.yesno(a)
extension[T] (a: T) def yesno(using yesno: YesNo[T]) = yesno.yesno(a)

def main(args: Array[String]): Unit = {
  val mInt4 = MyInt(4)
  val mInt5 = MyInt(5)
  println(mInt4.yesno)
  println(mInt5.yesno)
  val listYesNo = summon[YesNo[List[Int]]]
  println(listYesNo.yesno(List(1,2)))
  println(List(1,2).yesno)
}
```

