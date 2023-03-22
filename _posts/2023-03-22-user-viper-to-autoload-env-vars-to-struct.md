---
layout: post
title:  use viper to autoload env vars to struct 
date:   2023-03-22 10:19 
categories: tech 
---

# Introduction: 

Configuration management is an important part of any software application. It helps to manage different environments such as development, staging, production, etc. Viper is one of the popular configuration management libraries written for Go. It provides a simple and efficient way to read, write and manage configuration files. In this blog post, we will focus on how to configure viper to read environment variables.

## Step 1: Bind the environment variables based on the struct

The first step is traverse the structure and then bind the environment variable based on the respective struct field.

We have defined a `getFlattenKeys` function which takes the prefix and the reflect value as arguments. This function is responsible for returning the flattened keys for configuration. If the value of `v.Kind()` is `reflect.Struct`, we traverse the structure and recursively call the `getFlattenKeys` function. If the value of `v.Kind()` is anything else, we append the prefix to the keys.

```
func getFlattenKeys(prefix string, v reflect.Value) (keys []string) {
	switch v.Kind() {
	case reflect.Struct:
		for i := 0; i < v.NumField(); i++ {
			field := v.Field(i)
			name := v.Type().Field(i).Name
			keys = append(keys, getFlattenKeys(prefix+name+".", field)...)
		}
	default:
		keys = append(keys, prefix[:len(prefix)-1])
	}
	return keys
}
```

We use the `getFlattenKeys` function to get the flattened keys for our configuration structure. We then bind the environment variables to the respective keys using the `viper.BindEnv` function.

```
for _, key := range getFlattenKeys("", reflect.ValueOf(appConfig)) {
	envKey := strings.ToUpper(strings.ReplaceAll(key, ".", "_"))
	err := viper.BindEnv(key, envKey)
	if err != nil {
		logger.Fatal("config: unable to bind env: " + err.Error())
	}
}
```

## Step 2: Load the environment variables

In this step, we load the environment variables using the `viper.AutomaticEnv()` function.

```
viper.AutomaticEnv()
```

This function loads all environment variables that are currently set.

## Step 3: Unmarshal the environment variables into the struct

Finally, we use the `viper.Unmarshal` function to unmarshal the environment variables into the struct.

```
if err := viper.Unmarshal(&appConfig); err != nil {
	logger.Fatal("config: unable to decode into struct: " + err.Error())
}
```

The `Unmarshal` function takes a pointer to the struct as its argument and assigns the values to the respective fields.

Conclusion:

In this blog post, we have shown how to configure viper to read environment variables. We have defined a `getFlattenKeys` function that returns flattened keys for viper configuration. We have used reflection to bind the environment variables to the respective struct fields. We have then loaded the environment variables using `viper.AutomaticEnv()` and unmarshaled them into the struct using `viper.Unmarshal`.


