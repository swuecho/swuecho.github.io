---
layout: post
title:  jackson for json processing in java
date:   2025-05-02 12:21
categories: tech 
---

isGetter in Jackson


```java
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor // <-- Add this annotation
// @AllArgsConstructor // Optional: Add this if you want a constructor for ALL fields too
public class Status {
    private boolean isActive; // Java field name
    private String message;

    public boolean isMessageExists() {
        return !this.message.isEmpty();
    }

    public Status(boolean isActive, String message) {
        this.isActive = isActive;
        this.message = message;
    }

}
```

### 序列化:

```java
   @Test
    public void testIsGetterWriter()  throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        Status status = new Status(true, "System online");
        String json = mapper.writeValueAsString(status);
        assertEquals(json, "{\"message\":\"System online\",\"active\":true,\"messageExists\":true}");
    }

```

虽然Status 并没有messageExists这个field,但是因为is Getter的存在, 导致json 会塞进去 messageExists 值.
另外, isActive 序列化之后对应的key 是 active 而不是isActive


### 反序列化

```java
  @Test
    public void TestIsGetterReaderThrow() throws  Exception {
        ObjectMapper mapper = new ObjectMapper();
        String jsonInput =  "{\"message\":\"System online\",\"isActive\":true}";

        // 2. Act: Deserialize the JSON string into a Status object
        Status deserializedStatus = mapper.readValue(jsonInput, Status.class);

        // 3. Assert: Verify the fields of the deserialized object
        assertNotNull(deserializedStatus);
        assertTrue(deserializedStatus.isActive(), "Deserialized status should be active");
        assertEquals("System online", deserializedStatus.getMessage(), "Deserialized message should match");

        // Also verify the derived property works correctly on the deserialized object
        assertTrue(deserializedStatus.isMessageExists(), "isMessageExists() should return true based on deserialized message");
    }
```

上面的测试, 会报错, 根源在于 isActive vs Active.

```bash
com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException: Unrecognized field "isActive" (class org.example.Status), not marked as ignorable (2 known properties: "active", "message"])
 at [Source: REDACTED (`StreamReadFeature.INCLUDE_SOURCE_IN_LOCATION` disabled); line: 1, column: 43] (through reference chain: org.example.Status["isActive"])
```

把jsonInput中的 isActive 改成 active 就可以了

### 为什么会这样呢?

java bean spec 8.3.2


In addition, for boolean properties, we allow a getter method to match the pattern:
public boolean is<PropertyName>();
This “is<PropertyName>” method may be provided instead of a “get<PropertyName>” method, or it may be provided in addition to a “get<PropertyName>” method.
In either case, if the “is<PropertyName>” method is present for a boolean property then we will
use the “is<PropertyName>” method to read the property value.
An example boolean property might be:

```java
public boolean isMarsupial();
public void setMarsupial(boolean m);
```



source code:

https://github.com/swuecho/java-lombok-jackson

src/test/java/StatusTest.java