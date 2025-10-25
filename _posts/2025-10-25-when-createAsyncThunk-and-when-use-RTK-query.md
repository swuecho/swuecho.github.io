---
layout: post
title:  when createAsyncThunk and when use RTK query
date:   2025-10-25 03:53
categories: tech 
---

**system** <sup><kbd><var>2025-07-12T09:13:00Z</var></kbd></sup>:
 You are a expert on javascript and react}

----

**user** <sup><kbd><var>2025-07-15T14:20:50Z</var></kbd></sup>:
 teach me createAsyncThunk. why is it useful?

----

**assistant** <sup><kbd><var>2025-07-15T14:24:13Z</var></kbd></sup>:
 createAsyncThunk is a utility that ships with **Redux Toolkit (RTK)**.  
It lets you express a “side-effect” (usually an HTTP call) as one **action creator** that **dispatches three separate redux actions** for you:

1. `pending`  
2. `fulfilled` (with the server’s response)  
3. `rejected` (with the thrown error)

You stop writing that boilerplate yourself (dispatching a *_REQUEST* → do fetch → dispatch *_SUCCESS* or *_FAILURE*) and get automatic loading / error flags, strong typing with TS, cancellation, optimistic updates, etc.

---

### 1. The problem createAsyncThunk solves

Classic hand-written:

```js
// 1. action types
const FETCH_USER_REQUEST = 'FETCH_USER_REQUEST'
const FETCH_USER_SUCCESS = 'FETCH_USER_SUCCESS'
const FETCH_USER_FAILURE = 'FETCH_USER_FAILURE'

// 2. action creators
const fetchUserRequest = () => ({ type: FETCH_USER_REQUEST })
const fetchUserSuccess = user => ({ type: FETCH_USER_SUCCESS, payload: user })
const fetchUserFailure = error => ({ type: FETCH_USER_FAILURE, payload: error })

// 3. thunk action creator
export const fetchUser = id => async dispatch => {
  dispatch(fetchUserRequest())
  try {
    const res = await axios.get(`/users/${id}`)
    dispatch(fetchUserSuccess(res.data))
  } catch (e) {
    dispatch(fetchUserFailure(e.message))
  }
}
```

That is **12 lines** only for the plumbing.  
With createAsyncThunk:

```js
import { createAsyncThunk } from '@reduxjs/toolkit'

export const fetchUser = createAsyncThunk(
  'users/fetchUser',              // action prefix → creates 3 actions with /pending /fulfilled /rejected suffixes
  async (id, { rejectWithValue }) => {
    const res = await axios.get(`/users/${id}`)
    return res.data                // becomes action.payload for fulfilled
  }
)
```

5 lines. The rest is generated for you.

---

### 2. How to use it (step-by-step)

1. Generate the thunk:

```js
import { createAsyncThunk, createSlice } from '@reduxjs/toolkit'

export const fetchUser = createAsyncThunk(
  'users/fetchUser',
  async (userId, thunkAPI) => {
    try {
      const { data } = await axios.get(`/users/${userId}`)
      return data
    } catch (err) {
      // Optional: pick off the server’s error message
      return thunkAPI.rejectWithValue(err.response.data)
    }
  }
)
```

2. Wire it up in a slice:

```js
const usersSlice = createSlice({
  name: 'users',
  initialState: { entity: null, loading: false, error: null },
  reducers: {},                              // optional normal sync reducers
  extraReducers: builder => {
    builder
      .addCase(fetchUser.pending, state => {
        state.loading = true
        state.error = null
      })
      .addCase(fetchUser.fulfilled, (state, action) => {
        state.loading = false
        state.entity = action.payload
      })
      .addCase(fetchUser.rejected, (state, action) => {
        state.loading = false
        state.error = action.payload || action.error.message
      })
  }
})

export default usersSlice.reducer
```

3. Dispatch from a React component:

```jsx
import { useEffect } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { fetchUser } from './usersSlice'

function User({ id }) {
  const dispatch = useDispatch()
  const { entity, loading, error } = useSelector(s => s.users)

  useEffect(() => {
    dispatch(fetchUser(id))
  }, [id])

  if (loading) return <Spinner />
  if (error) return <p>{error}</p>
  return <div>{entity.name}</div>
}
```

---

### 3. Why it’s more than just “saves lines”

- **Automatic loading states**: use `pending`, `fulfilled`, `rejected` to set `loading` / `error` – no race conditions.
- **Cancellable**: you get an `AbortController`.  
  `thunkAPI.signal` lets you wire `fetch(url, { signal })`.

```js
const fetchWithAbort = createAsyncThunk('todos/get', async (_, thunkAPI) => {
  const res = await fetch('/todos', { signal: thunkAPI.signal })
  return res.json()
})
```

- **Serializing/thunk environment**:  
  - `getState()` → read the whole store.  
  - `dispatch()` → dispatch any other action or thunk.  
- **Serializable check** passes – all error objects are made serializable for Redux DevTools.

- **TypeScript**: `createAsyncThunk<User, string, { state: RootState }>()` gives you correct action & payload types everywhere.

---

### 4. Common mini-patterns

1. **Transform the server payload before it hits reducers**:

```js
createAsyncThunk('todos/fetch', async () => {
  const data = await api.fetchTodos()
  return data.map(t => ({ ...t, isSelected: false }))
})
```

2. **Reject with a shaped error so your reducer can draw UI**:

```js
return rejectWithValue({ status: 422, errors: err.response.data.errors })
```

3. **Chain dependent calls**:

```js
const initApp = createAsyncThunk('app/init', async (_, thunkAPI) => {
  await thunkAPI.dispatch(authenticate())
  return thunkAPI.dispatch(fetchProfile()).unwrap()   // returns the payload
})
```

---

TL;DR  
createAsyncThunk is the RTK tool that kills **90 % of Redux async boilerplate** while giving you **strong typing, cancellation, error serialization** and a **clean separation** between async side-effects and your pure reducers.

----

**user** <sup><kbd><var>2025-07-15T14:25:27Z</var></kbd></sup>:
 when it will go to rejected? please tell me the exact situation.

----

**assistant** <sup><kbd><var>2025-07-15T14:25:51Z</var></kbd></sup>:
 There are **only two** strictly-defined code paths that make a `createAsyncThunk` jump into the **rejected** action:

| Location | Exact code the thunk executes | Outcome |
|----------|-------------------------------|---------|
| 1️⃣ **Your async payloadCreator throws synchronously** OR an **awaited Promise rejects** and you do **NOT catch it**. | Anything that ends up like `throw …` or a rejected Promise bubbling out. | Redux Toolkit automatically catches it → **rejected** action with `action.error` filled. |
| 2️⃣ **You explicitly return `rejectWithValue(payload)`** (after catching an error, validation failure, business rule, etc.). | `catch (e) { return rejectWithValue(e) }` inside the payloadCreator. | Toolkit immediately shortcuts to **rejected** action with `action.payload === whatever you passed to rejectWithValue`. |

That’s the whole list.  
Any other branch (`return someData`, `return undefined`, even `return null`) lands in **fulfilled**.