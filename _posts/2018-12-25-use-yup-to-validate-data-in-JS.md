---
layout: post
title:  use yup to validate data in JS 
date:   2018-12-25 19:38 
categories: tech 
---

## validate a string

```{javascript}
const yup = require("yup")
let name = "echo@mail.com";
let schema = yup.string().email() ;

schema.isValidSync(name)
```
![run](https://runkit.com/swuecho/yup-test-string)

# validate a object 

```{javascript}
const yup = require("yup")
var login_schema =yup.object().shape( {
    name: yup.string().required('name is required').email(),
    pwd: yup.string().required('pass is required')
})

let name_and_pass = {
    name: '',
    pwd: ''
}

try {
    login_schema.validateSync(name_and_pass);
} catch (e ){
    console.log(e.errors);
}
```
![run](https://runkit.com/swuecho/yup-validate-object)

```{javascript}
mixed.isValid(value: any, options: ?object): Promise<boolean>
mixed.isValidSync(value: any, options: ?object): boolean
```
isValidSync return boolean

```{javascript}
mixed.validate(value: any, options: ?object): Promise<any, ValidationError>
mixed.validateSync(value: any, options: ?object): any
```
validateSync will throw error when any of the validation fails

both of the async version return a promise of Sync version return type

