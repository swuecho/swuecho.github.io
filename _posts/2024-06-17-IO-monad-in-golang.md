---
layout: post
title:  IO monad in golang
date:   2024-06-17 15:29
categories: tech 
---

I have a hard time to understand monad in haskell. In the afternoon, I read the functional javascript book and then I ask llm to write a golang version for me. Suddenly, my head click and I think I understand IO monad finally.

```go
// https://go.dev/play/p/J3QFqd7MFzP
package main

import (
	"fmt"
)

// IO represents an action that can be performed and produces a value.
type IO[T any] func() (T, error)

// Unit creates an IO action that does nothing and returns the given value.
func Unit[T any](value T) IO[T] {
	return func() (T, error) {
		return value, nil
	}
}

// Of creates an IO action that returns the given value.
func Of[T any](value T) IO[T] {
	return func() (T, error) {
		return value, nil
	}
}

// Bind chains two IO actions together.
func Bind[T, U any](io1 IO[T], f func(T) IO[U]) IO[U] {
	return func() (U, error) {
		value, err := io1()
		if err != nil {
			return *new(U), err
		}
		return f(value)()
	}
}

// Then chains two IO actions together, ignoring the result of the first.
func Then[T, U any](io1 IO[T], io2 IO[U]) IO[U] {
	return func() (U, error) {
		_, err := io1()
		if err != nil {
			return *new(U), err
		}
		return io2()
	}
}

// Map applies a function to the result of an IO action.
func Map[T, U any](io IO[T], f func(T) U) IO[U] {
	return func() (U, error) {
		value, err := io()
		if err != nil {
			return *new(U), err
		}
		return f(value), nil
	}
}

// Do executes an IO action without returning its value.
func Do[T any](io IO[T]) IO[T] {
	return func() (T, error) {
		_, err := io()
		return *new(T), err
	}
}

// Println creates an IO action that prints a string to the console.
func Println(s string) IO[string] {
	return func() (string, error) {
		fmt.Println(s)
		return s, nil
	}
}

// ReadLine creates an IO action that reads a line from the console.
func ReadLine() IO[string] {
	return func() (string, error) {
		var line string
		_, err := fmt.Scanln(&line)
		return line, err
	}
}

func main() {
	// Read a line from the console and print it back.
	io := Bind(ReadLine(), func(line string) IO[string] {
		return Println(line)
	})

	// Execute the IO action.
	_, err := io()
	if err != nil {
		fmt.Println(err)
	}
}

```