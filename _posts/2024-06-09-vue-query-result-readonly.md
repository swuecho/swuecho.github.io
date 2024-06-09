---
layout: post
title:  vue query result readonly 
date:   2024-06-09 13:53 
categories: tech 
---

vue query result is readonly, which make sense because it is a state managed by vue query engine. If user change it by pass vue query, the state might have consistent problem.

However, in real world, it is not rare to bind the data to form. User input will write to the data.

The solution I find so far is to create new ref based on raw data of `useQuery`.

```js
const modelQuery = useQuery({
  queryKey: ['chat_models'],
  queryFn: fetchChatModel,
})


const data = ref<Chat.ChatModel[]>(toRaw(modelQuery.data.value))

watch(modelQuery.data, () => {
  data.value = toRaw(modelQuery.data.value)
})
```

In the code snippet, data is initilized based on `modelQuery` and a watcher is created.

## Why watcher is necessary?

`modeQuery` have state in it, when initilized the data might be not loaded yet.

## Why watcher is not enough?

```js
const modelQuery = useQuery({
  queryKey: ['chat_models'],
  queryFn: fetchChatModel,
})


const data = ref<Chat.ChatModel[]>([])

watch(modelQuery.data, () => {
  data.value = toRaw(modelQuery.data.value)
})
```

let's say the component is one of tab, when you switch away and back. The modelQuery's data might have finished loading. The watcher will not be triggered. `const data = ref<Chat.ChatModel[]>([])` will set the data to `ref([])`

The lesson learned from this is that vue query will handle the state, the timing of the state change is kind of `indepenent` of vue. 