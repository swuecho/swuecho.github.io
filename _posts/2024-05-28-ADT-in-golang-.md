---
layout: post
title:  ADT in golang
 
date:   2024-05-28 10:43 
categories: tech 
---

```haskell
// haskell version
data Shape = Circle Float Float Float | Rectangle Float Float Float Float

//surface function

surface :: Shape -> Float
surface (Circle _ _ r) = pi * r ^ 2
surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)
```

```go
package main

import (
	"log"
	"math"
)



type Circle struct {
	Radius float32
	X      float32
	W      float32
}

type Rectangle struct {
	Width  float32
	Height float32
	X      float32
	Y      float32
}

func (c Circle) surface() float32 {
	return c.Radius * c.Radius * math.Pi

}
func (r Rectangle) surface() float32 {
	return r.Height * r.Width
}

type Shape interface {
	surface() float32
}

func surface(s Shape) float32 {
	return s.surface()
}

func surfaceAll(s Shape) float32 {
	switch ns := s.(type) {
	case Circle:
		return ns.Radius * ns.Radius * math.Pi
	case Rectangle:
		return ns.Width * ns.Height
	default:
		log.Fatalf("unexpected type %T", ns)
		return 0
	}
}


func p7() {
	c1 := Circle{3.1, 1.1, 1.0}
	r1 := Rectangle{3.1, 3.1, 1.0, 1.0}
	println(c1.surface())
	println(r1.surface())
	println(surface(c1))
	println(surface(r1))
		println("surface all")
	println(surfaceAll(c1))
	println(surfaceAll(r1))
	s1 := []Shape{
		c1,
	 	r1,
	}
	println("range")
	for _, v := range s1 {
		println(surface(v))
	}
}

```

