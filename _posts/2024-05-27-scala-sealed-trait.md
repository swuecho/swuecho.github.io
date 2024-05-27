---
layout: post
title:  scala sealed trait 
date:   2024-05-27 21:03 
categories: tech 
---

scala sealed trait is similar with ADT in haskell

## Algebraic data types in haskell

A Shape with Circle | Rectangle

```haskell
// haskell version
data Shape = Circle Float Float Float | Rectangle Float Float Float Float

surface function
surface :: Shape -> Float
surface (Circle _ _ r) = pi * r ^ 2
surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)
```

## ADT in scala

```scala
sealed trait Shape

case class Circle(radius: Float, x: Float, y: Float) extends Shape
case class Rectangle(width: Float, height: Float, x: Float, y: Float)
    extends Shape

def surface(shape: Shape): Float =
  shape match
    case Circle(radius, _, _)           => radius * radius * 3.14f
    case Rectangle(width, height, _, _) => width * height

def main(args: Array[String]): Unit = {
  val c = Circle(1.0f, 1.0f, 1.0f)
  val r = Rectangle(1.0f, 1.0f, 1.0f, 1.0f)
  println(surface(c))
  println(surface(r))
}
```

The implementation is almost identical.