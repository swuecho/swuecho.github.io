---
layout: post
title:  Java new feature by example
date:   2025-10-12 00:20
categories: tech 
---


As a developer are entering in a java dev role, while reading https://neilmadden.blog/2025/09/12/rating-26-years-of-java-changes/, I need some google to know what is the author is talking about. In order to better learn, I write copy/write down.


## Static import

Static imports in Java allow you to use static members (fields and methods) of a class directly without qualifying them with the class name. This feature was introduced in Java 5. 
How to use static imports: 

You declare a static import using the import static keyword, followed by the fully qualified name of the static member or the class containing the static members. Importing a specific static member. 

```java
    import static java.lang.Math.PI; // Imports the static field PI from the Math class     
```

After this import, you can use PI directly in your code instead of Math.PI. 

• Importing all static members of a class: 

```java
    import static java.lang.Math.*; // Imports all static members from the Math class
```

After this import, you can use any static method or field from the Math class (e.g., sin(), cos(), sqrt()) directly without the Math. prefix. 

When to use static imports: 

Static imports can be useful in scenarios where you frequently access static members from a particular class, such as: 

• Constants: When using a set of constants from a dedicated constants class or frequently used mathematical constants like Math.PI. 
• Utility methods: When repeatedly calling static utility methods from a class, like those in java.lang.Math or custom utility classes. 
• Unit testing: To make unit tests more concise when asserting conditions using static methods from assertion libraries. 


It is generally recommended to import specific static members individually rather than using the wildcard * unless there's a clear and significant benefit to readability and conciseness. 




## switch expressions 


```java
String day = "MONDAY";
String dayType = switch (day) {
    case "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY" -> "Weekday";
    case "SATURDAY", "SUNDAY" -> "Weekend";
    default -> "Invalid Day";
};
System.out.println(dayType); // Output: Weekday
```

```java
int value = 10;
String result = switch (value) {
    case 10 -> {
        System.out.println("Processing value 10");
        yield "Ten";
    }
    case 20 -> "Twenty";
    default -> "Other";
};
System.out.println(result); // Output: Processing value 10, then Ten
```

## records

Java Records, introduced as a preview feature in JDK 14 and standardized in JDK 16, are a concise way to declare classes whose primary purpose is to store immutable data. They aim to reduce the boilerplate code often associated with creating simple data-carrying classes (POJOs), such as constructors, accessor methods (getters), equals(), hashCode(), and toString(). 
Key characteristics of Java Records: 

• Concise Declaration: You declare a record by listing its components within parentheses, and the Java compiler automatically generates the necessary methods. 

```java
    public record Point(int x, int y) {}
```

• Immutability: Record components are implicitly final, and records are implicitly final, meaning they cannot be extended. This promotes the creation of immutable data objects. 
• Automatic Method Generation: The compiler generates: 
	• A canonical constructor that takes all components as arguments. 
	• Accessor methods for each component (e.g., x() and y() for a Point record). 
	• equals() and hashCode() methods based on the record components. 
	• A toString() method that includes the record's name and component values. 

• Restrictions: 
	• Records cannot extend any class (they implicitly extend java.lang.Record). 
	• They cannot declare instance fields other than the private final fields corresponding to the record components. [1]  
	• They cannot be abstract. 

• Flexibility: 
	• Records can implement interfaces. 
	• They can include custom constructors (including compact constructors for validation), static methods, static fields, and nested types. 
	• They can be generic. 
	• Record components and the record class itself can be annotated. 

Benefits of using Records: 

• Reduced Boilerplate: Significantly less code to write for data-carrying classes. 
• Improved Readability: The intent of the class as a data holder is immediately clear. 
• Enhanced Reliability: Immutability by default helps prevent unintended state changes. 
• Better Tooling Support: IDEs and other tools can leverage the well-defined structure of records. 

In essence, Java Records provide a streamlined and safer way to define immutable data aggregates in Java, making code cleaner and more robust. 

[1] https://docs.oracle.com/en/java/javase/14/language/records.html


## record patterns

```java
public record GPSPoint (double latitude, double longitude) {}
public record Location (String name, GPSPoint gpsPoint) {}
```



```java
String result = switch (object) {
    case Location(var name, var ignored) when name.equals("Home") -> new Location("Test", new GPSPoint(1.0, 2.0)).getName();
    case Location(var name, var ignored) -> name;
    default -> "default";
};
```


https://www.baeldung.com/java-19-record-patterns
