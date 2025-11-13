---
layout: post
title:  RTK Query to Slice Strategies, Avoid Duplication, Best Practices
date:   2025-10-28 05:12
categories: tech 
---

**system** <sup><kbd><var>2025-10-22T04:59:30Z</var></kbd></sup>:
 You are expert on react.

----

**user** <sup><kbd><var>2025-10-25T05:08:40Z</var></kbd></sup>:
 how to put the rtk query result to slice in rtk t

----

**assistant** <sup><kbd><var>2025-10-25T05:09:27Z</var></kbd></sup>:
 You can't directly put RTK Query results into a Redux slice because RTK Query manages its own cache separate from your normal Redux state. However, here are several approaches to work with RTK Query data in your slices:

## Approach 1: Transform Data in Components (Recommended)
```jsx
// In your component
import { useGetPostsQuery } from './apiSlice';
import { useDispatch } from 'react-redux';
import { setPosts } from './postsSlice';

function MyComponent() {
  const dispatch = useDispatch();
  const { data: posts, isLoading } = useGetPostsQuery();
  
  // Transform and dispatch to slice when data is available
  React.useEffect(() => {
    if (posts) {
      const transformedPosts = posts.map(post => ({
        ...post,
        processed: true,
        timestamp: new Date().toISOString()
      }));
      dispatch(setPosts(transformedPosts));
    }
  }, [posts, dispatch]);

  // Your component logic...
}
```

## Approach 2: Use Query Data in ExtraReducers
```javascript
// postsSlice.js
import { createSlice } from '@reduxjs/toolkit';
import { api } from './apiSlice';

const postsSlice = createSlice({
  name: 'posts',
  initialState: {
    items: [],
    processedItems: []
  },
  reducers: {
    setProcessedPosts: (state, action) => {
      state.processedItems = action.payload;
    }
  },
  extraReducers: (builder) => {
    builder.addMatcher(
      api.endpoints.getPosts.matchFulfilled,
      (state, action) => {
        // Transform and store the data
        state.items = action.payload;
        state.processedItems = action.payload.map(post => ({
          ...post,
          processed: true
        }));
      }
    );
  }
});

export const { setProcessedPosts } = postsSlice.actions;
export default postsSlice.reducer;
```

## Approach 3: Manual Cache Access
```javascript
// In your component or thunk
import { useDispatch } from 'react-redux';
import { api } from './apiSlice';
import { setPosts } from './postsSlice';

function useProcessPosts() {
  const dispatch = useDispatch();
  
  const processAndStorePosts = () => {
    // Get data from RTK Query cache
    const posts = api.endpoints.getPosts.select()(store.getState()).data;
    
    if (posts) {
      const transformed = posts.map(post => ({
        ...post,
        processed: true
      }));
      dispatch(setPosts(transformed));
    }
  };
  
  return processAndStorePosts;
}
```

## Approach 4: Using onQueryStarted (for mutations)
```javascript
// In your API slice
export const apiSlice = createApi({
  reducerPath: 'api',
  baseQuery: fetchBaseQuery({ baseUrl: '/api' }),
  endpoints: (builder) => ({
    createPost: builder.mutation({
      query: (postData) => ({
        url: '/posts',
        method: 'POST',
        body: postData,
      }),
      onQueryStarted: async (arg, { dispatch, queryFulfilled }) => {
        try {
          const { data: newPost } = await queryFulfilled;
          // Dispatch to your slice
          dispatch(addToLocalPosts(newPost));
        } catch (error) {
          // Handle error
        }
      },
    }),
  }),
});
```

## Best Practices:

1. **Keep RTK Query for server state** - Use it for API calls and caching
2. **Use slices for client state** - Local transformations, UI state, derived data
3. **Transform data in components** - Most flexible approach
4. **Avoid duplicating data** - Reference RTK Query cache when possible

## Complete Example:
```javascript
// apiSlice.js
export const apiSlice = createApi({
  reducerPath: 'api',
  baseQuery: fetchBaseQuery({ baseUrl: '/api' }),
  tagTypes: ['Post'],
  endpoints: (builder) => ({
    getPosts: builder.query({
      query: () => '/posts',
      providesTags: ['Post'],
    }),
  }),
});

// postsSlice.js
const postsSlice = createSlice({
  name: 'posts',
  initialState: {
    localPosts: [],
    filters: {},
  },
  reducers: {
    addLocalPost: (state, action) => {
      state.localPosts.push(action.payload);
    },
    setFilters: (state, action) => {
      state.filters = action.payload;
    },
  },
});

// Component
function PostsList() {
  const { data: posts } = useGetPostsQuery();
  const localPosts = useSelector(state => state.posts.localPosts);
  const dispatch = useDispatch();
  
  // Combine and transform data
  const allPosts = [...(posts || []), ...localPosts];
  
  return (
    <div>
      {allPosts.map(post => (
        <PostItem key={post.id} post={post} />
      ))}
    </div>
  );
}
```

The key is to use RTK Query for what it's good at (API calls, caching, invalidation) and use regular slices for client-side state management and data transformations.

----

**user** <sup><kbd><var>2025-10-25T05:14:06Z</var></kbd></sup>:
 why in approach addMatcher is used instead of addCase

----

**assistant** <sup><kbd><var>2025-10-25T05:14:50Z</var></kbd></sup>:
 Great question! The difference between `addMatcher` and `addCase` is important in RTK:

## `addCase` vs `addMatcher`

### `addCase` - For Specific Action Types
```javascript
// Only works with actions created by createSlice/createAction
extraReducers: (builder) => {
  builder.addCase(someAction, (state, action) => {
    // Handle specific action
  });
}
```

### `addMatcher` - For Pattern Matching
```javascript
// Works with any action that matches a pattern
extraReducers: (builder) => {
  builder.addMatcher(
    api.endpoints.getPosts.matchFulfilled,
    (state, action) => {
      // Handle any fulfilled getPosts query
    }
  );
}
```

## Why `addMatcher` for RTK Query?

### 1. **RTK Query Generates Multiple Action Types**
Each query/mutation generates multiple actions:
- `getPosts/pending`
- `getPosts/fulfilled` 
- `getPosts/rejected`

```javascript
// These won't work with addCase:
builder.addCase('api/executeQuery/fulfilled') // ❌ Too generic
builder.addCase('getPosts/fulfilled') // ❌ Not the full action type

// But these work with addMatcher:
builder.addMatcher(api.endpoints.getPosts.matchFulfilled, ...) // ✅
builder.addMatcher(api.endpoints.getPosts.matchPending, ...) // ✅
```

### 2. **Type Safety**
```javascript
// addMatcher provides better TypeScript support
builder.addMatcher(
  api.endpoints.getPosts.matchFulfilled,
  (state, action) => {
    // action.payload is properly typed as the response type
    state.posts = action.payload; // ✅ Type-safe
  }
);
```

### 3. **Flexible Pattern Matching**
```javascript
// Match multiple endpoints
builder.addMatcher(
  (action) => action.type.endsWith('/fulfilled'),
  (state, action) => {
    // Handle ANY fulfilled request
  }
);

// Match specific error patterns
builder.addMatcher(
  (action) => action.type.endsWith('/rejected') && action.payload?.status === 404,
  (state, action) => {
    // Handle 404 errors from any endpoint
  }
);
```

## When to Use Each:

### Use `addCase` for:
- Actions from your own slices
- Specific, known action types
- Simple, direct action handling

```javascript
import { fetchUser } from './userSlice';

extraReducers: (builder) => {
  builder.addCase(fetchUser.fulfilled, (state, action) => {
    state.user = action.payload;
  });
}
```

### Use `addMatcher` for:
- RTK Query actions
- Pattern-based action matching
- Handling groups of similar actions

```javascript
extraReducers: (builder) => {
  // Handle any post-related queries
  builder.addMatcher(
    (action) => action.type.includes('posts') && action.type.endsWith('/fulfilled'),
    (state, action) => {
      state.lastUpdated = new Date().toISOString();
    }
  );
  
  // Specific RTK Query endpoint
  builder.addMatcher(
    api.endpoints.getPosts.matchFulfilled,
    (state, action) => {
      state.posts = action.payload;
    }
  );
}
```

## Complete Example:

```javascript
// apiSlice.js
export const api = createApi({
  endpoints: (builder) => ({
    getPosts: builder.query({ query: () => '/posts' }),
    getUser: builder.query({ query: (id) => `/users/${id}` }),
  }),
});

// appSlice.js  
const appSlice = createSlice({
  name: 'app',
  initialState: {
    posts: [],
    user: null,
    loading: false,
    errors: []
  },
  reducers: {},
  extraReducers: (builder) => {
    // Using addCase for our own actions
    builder.addCase(clearErrors, (state) => {
      state.errors = [];
    });
    
    // Using addMatcher for RTK Query
    builder.addMatcher(
      api.endpoints.getPosts.matchFulfilled,
      (state, action) => {
        state.posts = action.payload;
      }
    );
    
    builder.addMatcher(
      api.endpoints.getUser.matchFulfilled,
      (state, action) => {
        state.user = action.payload;
      }
    );
    
    // Pattern matching for loading states
    builder.addMatcher(
      (action) => action.type.endsWith('/pending'),
      (state) => {
        state.loading = true;
      }
    );
    
    builder.addMatcher(
      (action) => action.type.endsWith('/fulfilled') || action.type.endsWith('/rejected'),
      (state) => {
        state.loading = false;
      }
    );
  }
});
```

**Bottom line**: Use `addMatcher` for RTK Query because it provides the type-safe, pattern-matching capability needed to handle the dynamically generated action types that RTK Query creates.

----

**assistant** <sup><kbd><var>2025-10-25T05:16:25Z</var></kbd></sup>:
 Excellent question! You're right to question this, and there's actually a **better approach** I should have shown you.

## The Better Way: Use `api.util.getRunningOperationPromises()`

Actually, for RTK Query, the **recommended approach** is to use the query hooks directly in components rather than trying to move data into slices. But if you need to access query results in thunks or other parts of your app, here's the proper way:

## Approach 1: Use Query Hooks in Components (Recommended)
```jsx
// Just use the query hook directly - no need for extra slice logic
function PostsList() {
  const { data: posts, isLoading, error } = useGetPostsQuery();
  
  // Your component logic here
  return <div>{/* render posts */}</div>;
}
```

## Approach 2: Access Cache Data Directly (When You Really Need To)
```javascript
// In a thunk or selector
import { api } from './apiSlice';

// In a thunk
const fetchAndProcessPosts = () => async (dispatch, getState) => {
  // Trigger the query
  const result = await dispatch(api.endpoints.getPosts.initiate());
  
  // Access the cached data
  const posts = api.endpoints.getPosts.select()(getState()).data;
  
  if (posts) {
    // Do something with the posts
    dispatch(someOtherAction(posts));
  }
  
  // Unsubscribe if needed
  result.unsubscribe();
};

// In a selector
const selectProcessedPosts = createSelector(
  [state => api.endpoints.getPosts.select()(state).data],
  (posts) => posts?.map(post => ({ ...post, processed: true })) || []
);
```

## Approach 3: Using `getRunningOperationPromises()` (For SSR/Next.js)
```javascript
// In Next.js getServerSideProps or similar
export const getServerSideProps = wrapper.getServerSideProps(
  (store) => async (context) => {
    // Dispatch the query
    store.dispatch(api.endpoints.getPosts.initiate());
    
    // Wait for all running queries to complete
    await Promise.all(api.util.getRunningOperationPromises());
    
    // Access the data
    const posts = api.endpoints.getPosts.select()(store.getState()).data;
    
    return {
      props: { posts }
    };
  }
);
```

## Why Avoid `addMatcher` for RTK Query Data?

### 1. **Data Duplication**
```javascript
// ❌ Don't do this - duplicates data
extraReducers: (builder) => {
  builder.addMatcher(
    api.endpoints.getPosts.matchFulfilled,
    (state, action) => {
      state.posts = action.payload; // Now posts exist in TWO places!
    }
  );
}

// ✅ RTK Query already caches this efficiently
const { data: posts } = useGetPostsQuery(); // Single source of truth
```

### 2. **Cache Invalidation Issues**
RTK Query handles cache invalidation automatically, but if you copy data to a slice:
- You lose automatic refetching on component mount
- You have to manually handle cache invalidation
- You might show stale data

### 3. **Better Alternatives**

**For derived data:**
```javascript
// Use selectors to transform cached data
const selectFeaturedPosts = createSelector(
  [state => api.endpoints.getPosts.select()(state).data],
  (posts) => posts?.filter(post => post.featured) || []
);

// Use in component
const featuredPosts = useSelector(selectFeaturedPosts);
```

**For client-side state:**
```javascript
// Keep client state separate
const postsSlice = createSlice({
  name: 'posts',
  initialState: {
    filters: {},
    sortOrder: 'newest',
    selectedPostId: null
  },
  reducers: {
    setFilters: (state, action) => {
      state.filters = action.payload;
    }
  }
});
```

## When You Might Actually Need `addMatcher`:

```javascript
// For side effects, not data storage
extraReducers: (builder) => {
  builder.addMatcher(
    api.endpoints.getPosts.matchFulfilled,
    (state, action) => {
      // Just update metadata, don't store the actual posts
      state.lastFetchTime = new Date().toISOString();
      state.fetchCount += 1;
    }
  );
  
  builder.addMatcher(
    api.endpoints.getPosts.matchRejected,
    (state, action) => {
      // Track errors without storing data
      state.lastError = action.error.message;
    }
  );
}
```

## The Right Mental Model:

| Use RTK Query For | Use Slices For |
|-------------------|----------------|
| Server state | Client state |
| API data | UI state |
| Caching | Form data |
| Background refetching | Selections/filters |
| Optimistic updates | Local transformations |

**Bottom line**: Let RTK Query manage your server state, and use regular slices for true client-side state. Use selectors to combine and transform data as needed, rather than duplicating it across the store.

The `addMatcher` approach I initially showed creates unnecessary complexity - stick with the query hooks directly in components for most use cases!
