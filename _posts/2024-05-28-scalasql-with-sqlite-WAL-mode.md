---
layout: post
title:  scalasql with sqlite WAL mode 
date:   2024-05-28 15:36 
categories: tech 
---

## run with scala-cli

```scala
//> using scala "3.4.2"
//> using dep "org.xerial:sqlite-jdbc:3.46.0.0"
//> using dep "com.lihaoyi::scalasql:0.1.3"

import scalasql.Table
import scalasql.SqliteDialect._

object SqliteExample {

  case class ExampleProduct[T[_]](
      id: T[Int],
      kebabCaseName: T[String],
      name: T[String],
      price: T[Double]
  )

  object ExampleProduct extends Table[ExampleProduct]

  def sqliteConfig(): org.sqlite.SQLiteConfig =
    // sqlite JournalMode wal
    val journalMode = org.sqlite.SQLiteConfig.JournalMode.WAL
    val sqliteConfig = new org.sqlite.SQLiteConfig()
    sqliteConfig.setJournalMode(journalMode)
    sqliteConfig

  def sqliteDataSource(
      config: org.sqlite.SQLiteConfig,
      dbPath: String
  ): org.sqlite.SQLiteDataSource =
    val ds = new org.sqlite.SQLiteDataSource(config)
    ds.setUrl(s"jdbc:sqlite:$dbPath/file.db")
    return ds

  lazy val sqliteClient: scalasql.DbClient.DataSource =
    new scalasql.DbClient.DataSource(
      sqliteDataSource(sqliteConfig(), "./data"),
      config = new scalasql.Config {}
    )

  def main(args: Array[String]): Unit = {
    val db = sqliteClient.getAutoCommitClientConnection

    db.updateRaw("""
      CREATE TABLE IF NOT EXISTS  example_product (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          kebab_case_name VARCHAR(256),
          name VARCHAR(256),
          price DECIMAL(20, 2)
      );
      """)
    val t0 = System.currentTimeMillis()
    println(t0)
    for (_ <- 1 to 100000) {
      val inserted = db.run(
        ExampleProduct.insert.batched(_.kebabCaseName, _.name, _.price)(
          ("face-mask", "Face Mask", 8.88),
          ("guitar", "Guitar", 300),
          ("socks", "Socks", 3.14),
          ("skate-board", "Skate Board", 123.45),
          ("camera", "Camera", 1000.00),
          ("cookie", "Cookie", 0.10)
        )
      )
    }
    val t1 = System.currentTimeMillis()
    println(t1)
    println(t1 - t0)
    db.close() // have to close the db connection

  }
}


```

