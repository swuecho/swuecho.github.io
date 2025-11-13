---
layout: post
title:  React Async Thunk: Complex API Query Chains
date:   2025-10-26 04:46
categories: tech 
---

**system** <sup><kbd><var>2025-10-22T04:59:30Z</var></kbd></sup>:
 You are expert on react.

----

**user** <sup><kbd><var>2025-10-25T04:45:35Z</var></kbd></sup>:
 createAsyncThunk for complex query logic. for example, when post user info, have to get the encrypt token first by api request

----

**assistant** <sup><kbd><var>2025-10-25T04:46:40Z</var></kbd></sup>:
 Here's how to create an async thunk with complex query logic that first fetches an encryption token and then uses it to post user data:

## Basic Implementation

```javascript
import { createAsyncThunk } from '@reduxjs/toolkit';

// Async thunk for posting user info with encryption token
export const postUserWithEncryption = createAsyncThunk(
  'user/postWithEncryption',
  async (userData, { rejectWithValue }) => {
    try {
      // Step 1: Get encryption token first
      const tokenResponse = await fetch('/api/auth/encryption-token', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      if (!tokenResponse.ok) {
        throw new Error('Failed to get encryption token');
      }

      const { encryptionToken } = await tokenResponse.json();

      // Step 2: Use the token to encrypt and post user data
      const encryptedData = {
        ...userData,
        encrypted: true,
        token: encryptionToken,
        // Add your encryption logic here
        payload: await encryptData(userData, encryptionToken),
      };

      const userResponse = await fetch('/api/users', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${encryptionToken}`,
        },
        body: JSON.stringify(encryptedData),
      });

      if (!userResponse.ok) {
        throw new Error('Failed to post user data');
      }

      return await userResponse.json();
    } catch (error) {
      return rejectWithValue(error.message);
    }
  }
);

// Helper function for encryption (example)
async function encryptData(data, token) {
  // Your encryption logic here
  return btoa(JSON.stringify({ data, token, timestamp: Date.now() }));
}
```

## Advanced Implementation with Error Handling

```javascript
export const postUserWithEncryption = createAsyncThunk(
  'user/postWithEncryption',
  async (userData, { rejectWithValue, dispatch }) => {
    try {
      // Step 1: Get encryption token with retry logic
      let encryptionToken;
      let retryCount = 0;
      const maxRetries = 3;

      while (retryCount < maxRetries) {
        try {
          const tokenResponse = await fetch('/api/auth/encryption-token', {
            method: 'GET',
            headers: {
              'Content-Type': 'application/json',
            },
          });

          if (tokenResponse.ok) {
            const result = await tokenResponse.json();
            encryptionToken = result.encryptionToken;
            break;
          }
        } catch (error) {
          retryCount++;
          if (retryCount === maxRetries) {
            throw new Error('Max retries reached for token acquisition');
          }
          // Wait before retry (exponential backoff)
          await new Promise(resolve => 
            setTimeout(resolve, 1000 * Math.pow(2, retryCount))
          );
        }
      }

      if (!encryptionToken) {
        throw new Error('Could not obtain encryption token');
      }

      // Step 2: Validate token expiration
      const tokenPayload = parseJwt(encryptionToken);
      if (tokenPayload.exp * 1000 < Date.now()) {
        throw new Error('Encryption token expired');
      }

      // Step 3: Prepare encrypted payload
      const encryptedPayload = await prepareEncryptedPayload(userData, encryptionToken);

      // Step 4: Post user data
      const userResponse = await fetch('/api/users', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-Encryption-Token': encryptionToken,
          'X-Request-ID': generateRequestId(),
        },
        body: JSON.stringify(encryptedPayload),
      });

      if (!userResponse.ok) {
        const errorData = await userResponse.json().catch(() => ({}));
        throw new Error(errorData.message || `HTTP ${userResponse.status}`);
      }

      const result = await userResponse.json();
      
      // Step 5: Optional - Clear sensitive data from memory
      encryptionToken = null;
      
      return result;

    } catch (error) {
      console.error('Post user with encryption failed:', error);
      return rejectWithValue({
        message: error.message,
        timestamp: new Date().toISOString(),
        operation: 'postUserWithEncryption'
      });
    }
  }
);

// Helper functions
function parseJwt(token) {
  try {
    return JSON.parse(atob(token.split('.')[1]));
  } catch {
    return {};
  }
}

async function prepareEncryptedPayload(data, token) {
  // Your complex encryption/transformation logic
  return {
    encrypted: true,
    version: '1.0',
    timestamp: new Date().toISOString(),
    payload: await complexEncryption(data, token),
    metadata: {
      algorithm: 'AES-256-GCM',
      keyId: extractKeyId(token),
    }
  };
}

async function complexEncryption(data, token) {
  // Implement your actual encryption logic
  const encoder = new TextEncoder();
  const dataBuffer = encoder.encode(JSON.stringify(data));
  // ... encryption implementation
  return btoa(JSON.stringify(data));
}

function extractKeyId(token) {
  // Extract key identifier from token
  return token.split('.')[0] || 'default';
}

function generateRequestId() {
  return `req_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
}
```

## Usage in Component

```javascript
import React, { useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { postUserWithEncryption } from './userSlice';

const UserForm = () => {
  const dispatch = useDispatch();
  const { loading, error, data } = useSelector(state => state.user);
  const [formData, setFormData] = useState({});

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    try {
      const result = await dispatch(postUserWithEncryption(formData)).unwrap();
      console.log('User created successfully:', result);
    } catch (error) {
      console.error('Failed to create user:', error);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      {/* Your form fields */}
      <button type="submit" disabled={loading}>
        {loading ? 'Creating...' : 'Create User'}
      </button>
      {error && <div className="error">{error.message}</div>}
    </form>
  );
};
```

## Slice Configuration

```javascript
import { createSlice } from '@reduxjs/toolkit';
import { postUserWithEncryption } from './userThunks';

const userSlice = createSlice({
  name: 'user',
  initialState: {
    loading: false,
    data: null,
    error: null,
    encryptionTokens: {},
  },
  reducers: {
    clearError: (state) => {
      state.error = null;
    },
  },
  extraReducers: (builder) => {
    builder
      .addCase(postUserWithEncryption.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(postUserWithEncryption.fulfilled, (state, action) => {
        state.loading = false;
        state.data = action.payload;
        state.error = null;
      })
      .addCase(postUserWithEncryption.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload;
      });
  },
});

export const { clearError } = userSlice.actions;
export default userSlice.reducer;
```

This implementation provides:

1. **Sequential API calls** - token first, then user data
2. **Error handling** with proper error propagation
3. **Retry logic** for token acquisition
4. **Token validation** and expiration checking
5. **Security considerations** for sensitive data
6. **Proper Redux state management**

You can customize the encryption logic and error handling based on your specific requirements.

----

**user** <sup><kbd><var>2025-10-25T04:47:30Z</var></kbd></sup>:
 How could this pattern be extended to handle more complex dependency chains where multiple sequential API calls are required before the final operation?

----

**assistant** <sup><kbd><var>2025-10-25T04:49:25Z</var></kbd></sup>:
 Here are several patterns for handling complex dependency chains with sequential API calls:

## 1. **Explicit Sequential Pattern**

```javascript
export const complexUserRegistration = createAsyncThunk(
  'user/complexRegistration',
  async (registrationData, { rejectWithValue }) => {
    try {
      // Step 1: Get encryption token
      const encryptionToken = await getEncryptionToken();
      
      // Step 2: Validate business rules
      const validationResult = await validateBusinessRules(registrationData);
      
      // Step 3: Check availability (depends on validation)
      const availability = await checkResourceAvailability(
        registrationData, 
        validationResult
      );
      
      // Step 4: Generate temporary storage
      const storageInfo = await createTemporaryStorage(
        registrationData, 
        encryptionToken
      );
      
      // Step 5: Final registration (depends on all previous steps)
      const user = await completeRegistration({
        ...registrationData,
        encryptionToken,
        validationId: validationResult.id,
        availabilityToken: availability.token,
        storageKey: storageInfo.key
      });
      
      // Step 6: Cleanup temporary resources
      await cleanupTemporaryResources(storageInfo.key);
      
      return user;
      
    } catch (error) {
      return rejectWithValue(error.message);
    }
  }
);

// Helper functions for each step
async function getEncryptionToken() {
  const response = await fetch('/api/auth/encryption-token');
  if (!response.ok) throw new Error('Token acquisition failed');
  const { token } = await response.json();
  return token;
}

async function validateBusinessRules(data) {
  const response = await fetch('/api/validation/business-rules', {
    method: 'POST',
    body: JSON.stringify(data)
  });
  if (!response.ok) throw new Error('Validation failed');
  return response.json();
}

async function checkResourceAvailability(data, validation) {
  const response = await fetch('/api/resources/availability', {
    method: 'POST',
    body: JSON.stringify({ data, validationId: validation.id })
  });
  if (!response.ok) throw new Error('Resource check failed');
  return response.json();
}

async function createTemporaryStorage(data, token) {
  const response = await fetch('/api/storage/temporary', {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${token}` },
    body: JSON.stringify(data)
  });
  if (!response.ok) throw new Error('Storage creation failed');
  return response.json();
}

async function completeRegistration(payload) {
  const response = await fetch('/api/users/register', {
    method: 'POST',
    body: JSON.stringify(payload)
  });
  if (!response.ok) throw new Error('Registration failed');
  return response.json();
}

async function cleanupTemporaryResources(storageKey) {
  await fetch(`/api/storage/temporary/${storageKey}`, {
    method: 'DELETE'
  });
}
```

## 2. **Pipeline Pattern with Dependency Injection**

```javascript
// Pipeline configuration
const registrationPipeline = [
  {
    name: 'encryptionToken',
    execute: async (data, context) => {
      const response = await fetch('/api/auth/encryption-token');
      return { token: (await response.json()).token };
    }
  },
  {
    name: 'validation',
    dependsOn: ['encryptionToken'],
    execute: async (data, context) => {
      const response = await fetch('/api/validation', {
        method: 'POST',
        headers: { 'X-Token': context.encryptionToken.token },
        body: JSON.stringify(data)
      });
      return await response.json();
    }
  },
  {
    name: 'availability',
    dependsOn: ['validation'],
    execute: async (data, context) => {
      const response = await fetch('/api/availability', {
        method: 'POST',
        body: JSON.stringify({
          data,
          validationId: context.validation.id
        })
      });
      return await response.json();
    }
  },
  {
    name: 'registration',
    dependsOn: ['encryptionToken', 'validation', 'availability'],
    execute: async (data, context) => {
      const response = await fetch('/api/register', {
        method: 'POST',
        body: JSON.stringify({
          ...data,
          encryptionToken: context.encryptionToken.token,
          validationContext: context.validation,
          availability: context.availability
        })
      });
      return await response.json();
    }
  }
];

export const pipelineRegistration = createAsyncThunk(
  'user/pipelineRegistration',
  async (userData, { rejectWithValue }) => {
    try {
      const context = {};
      
      for (const step of registrationPipeline) {
        // Check dependencies are available
        if (step.dependsOn) {
          const missingDeps = step.dependsOn.filter(dep => !context[dep]);
          if (missingDeps.length > 0) {
            throw new Error(`Missing dependencies: ${missingDeps.join(', ')}`);
          }
        }
        
        context[step.name] = await step.execute(userData, context);
      }
      
      return context.registration;
    } catch (error) {
      return rejectWithValue(error.message);
    }
  }
);
```

## 3. **Graph-Based Dependency Resolution**

```javascript
class AsyncDependencyGraph {
  constructor() {
    this.nodes = new Map();
  }
  
  addNode(name, executor, dependencies = []) {
    this.nodes.set(name, { executor, dependencies });
  }
  
  async execute(initialData) {
    const results = new Map();
    const visited = new Set();
    
    const visit = async (nodeName) => {
      if (visited.has(nodeName)) return;
      visited.add(nodeName);
      
      const node = this.nodes.get(nodeName);
      if (!node) throw new Error(`Unknown node: ${nodeName}`);
      
      // Execute dependencies first
      for (const dep of node.dependencies) {
        await visit(dep);
      }
      
      // Execute current node
      const dependencyResults = {};
      for (const dep of node.dependencies) {
        dependencyResults[dep] = results.get(dep);
      }
      
      const result = await node.executor(initialData, dependencyResults);
      results.set(nodeName, result);
    };
    
    // Execute all nodes
    for (const nodeName of this.nodes.keys()) {
      await visit(nodeName);
    }
    
    return Object.fromEntries(results);
  }
}

// Configure the dependency graph
const registrationGraph = new AsyncDependencyGraph();

registrationGraph.addNode('encryptionToken', async (data) => {
  const response = await fetch('/api/auth/encryption-token');
  return (await response.json()).token;
});

registrationGraph.addNode('validation', async (data, deps) => {
  const response = await fetch('/api/validation', {
    headers: { 'X-Token': deps.encryptionToken },
    body: JSON.stringify(data)
  });
  return response.json();
}, ['encryptionToken']);

registrationGraph.addNode('availability', async (data, deps) => {
  const response = await fetch('/api/availability', {
    body: JSON.stringify({
      data,
      validationId: deps.validation.id
    })
  });
  return response.json();
}, ['validation']);

registrationGraph.addNode('registration', async (data, deps) => {
  const response = await fetch('/api/register', {
    method: 'POST',
    body: JSON.stringify({
      ...data,
      encryptionToken: deps.encryptionToken,
      validationContext: deps.validation,
      availability: deps.availability
    })
  });
  return response.json();
}, ['encryptionToken', 'validation', 'availability']);

export const graphBasedRegistration = createAsyncThunk(
  'user/graphRegistration',
  async (userData, { rejectWithValue }) => {
    try {
      const results = await registrationGraph.execute(userData);
      return results.registration;
    } catch (error) {
      return rejectWithValue(error.message);
    }
  }
);
```

## 4. **State Machine Pattern with Progress Tracking**

```javascript
const RegistrationStates = {
  INIT: 'init',
  GETTING_TOKEN: 'getting_token',
  VALIDATING: 'validating',
  CHECKING_AVAILABILITY: 'checking_availability',
  CREATING_STORAGE: 'creating_storage',
  REGISTERING: 'registering',
  CLEANING_UP: 'cleaning_up',
  COMPLETED: 'completed',
  FAILED: 'failed'
};

export const stateMachineRegistration = createAsyncThunk(
  'user/stateMachineRegistration',
  async (userData, { rejectWithValue, dispatch }) => {
    let currentState = RegistrationStates.INIT;
    const context = {};
    
    const updateProgress = (state, data = null) => {
      currentState = state;
      dispatch(updateRegistrationProgress({ state, data }));
    };
    
    try {
      updateProgress(RegistrationStates.GETTING_TOKEN);
      context.encryptionToken = await getEncryptionToken();
      
      updateProgress(RegistrationStates.VALIDATING);
      context.validation = await validateBusinessRules(userData);
      
      updateProgress(RegistrationStates.CHECKING_AVAILABILITY);
      context.availability = await checkResourceAvailability(userData, context.validation);
      
      updateProgress(RegistrationStates.CREATING_STORAGE);
      context.storage = await createTemporaryStorage(userData, context.encryptionToken);
      
      updateProgress(RegistrationStates.REGISTERING);
      const result = await completeRegistration({
        ...userData,
        ...context
      });
      
      updateProgress(RegistrationStates.CLEANING_UP);
      await cleanupTemporaryResources(context.storage.key);
      
      updateProgress(RegistrationStates.COMPLETED, result);
      return result;
      
    } catch (error) {
      updateProgress(RegistrationStates.FAILED, { error: error.message });
      
      // Attempt cleanup on failure
      if (context.storage) {
        await cleanupTemporaryResources(context.storage.key).catch(() => {});
      }
      
      return rejectWithValue(error.message);
    }
  }
);

// Progress tracking slice
const registrationSlice = createSlice({
  name: 'registration',
  initialState: {
    currentState: RegistrationStates.INIT,
    progress: 0,
    stepData: null,
    error: null
  },
  reducers: {
    updateRegistrationProgress: (state, action) => {
      state.currentState = action.payload.state;
      state.stepData = action.payload.data;
      state.progress = calculateProgress(action.payload.state);
      if (action.payload.state === RegistrationStates.FAILED) {
        state.error = action.payload.data?.error;
      }
    }
  }
});

function calculateProgress(state) {
  const states = Object.values(RegistrationStates);
  const currentIndex = states.indexOf(state);
  return (currentIndex / (states.length - 1)) * 100;
}
```

## 5. **Composable Steps with Error Recovery**

```javascript
class ComposableWorkflow {
  constructor() {
    this.steps = [];
    this.rollbackActions = [];
  }
  
  addStep(name, execute, rollback = null, dependencies = []) {
    this.steps.push({ name, execute, rollback, dependencies });
  }
  
  async execute(initialData) {
    const context = {};
    
    for (let i = 0; i < this.steps.length; i++) {
      const step = this.steps[i];
      
      try {
        // Verify dependencies
        const missingDeps = step.dependencies.filter(dep => 
          !context[dep]
        );
        if (missingDeps.length > 0) {
          throw new Error(`Missing dependencies: ${missingDeps.join(', ')}`);
        }
        
        // Execute step
        const dependencyContext = {};
        step.dependencies.forEach(dep => {
          dependencyContext[dep] = context[dep];
        });
        
        context[step.name] = await step.execute(initialData, dependencyContext);
        
        // Register rollback if provided
        if (step.rollback) {
          this.rollbackActions.unshift({
            name: step.name,
            execute: step.rollback,
            context: { ...dependencyContext, [step.name]: context[step.name] }
          });
        }
        
      } catch (error) {
        console.error(`Step ${step.name} failed:`, error);
        
        // Execute rollback for completed steps
        await this.rollback();
        throw error;
      }
    }
    
    return context;
  }
  
  async rollback() {
    for (const action of this.rollbackActions) {
      try {
        await action.execute(action.context);
      } catch (rollbackError) {
        console.error(`Rollback failed for ${action.name}:`, rollbackError);
      }
    }
  }
}

// Usage
const workflow = new ComposableWorkflow();

workflow.addStep(
  'encryptionToken',
  async (data) => {
    const response = await fetch('/api/auth/encryption-token');
    return (await response.json()).token;
  }
);

workflow.addStep(
  'temporaryStorage',
  async (data, deps) => {
    const response = await fetch('/api/storage/temporary', {
      headers: { 'Authorization': `Bearer ${deps.encryptionToken}` },
      body: JSON.stringify(data)
    });
    return response.json();
  },
  async (context) => {
    // Rollback: delete temporary storage
    await fetch(`/api/storage/temporary/${context.temporaryStorage.key}`, {
      method: 'DELETE'
    });
  },
  ['encryptionToken']
);

// Export thunk using composable workflow
export const workflowRegistration = createAsyncThunk(
  'user/workflowRegistration',
  async (userData, { rejectWithValue }) => {
    try {
      const results = await workflow.execute(userData);
      return results.finalStep; // Return the final result
    } catch (error) {
      return rejectWithValue(error.message);
    }
  }
);
```

## Key Benefits of These Patterns:

1. **Explicit Dependencies** - Clear declaration of what depends on what
2. **Error Isolation** - Failures in one step don't break the entire flow
3. **Progress Tracking** - Monitor each step's completion
4. **Rollback Capability** - Clean up resources on failure
5. **Testability** - Each step can be tested independently
6. **Reusability** - Steps can be reused across different workflows
7. **Maintainability** - Clear separation of concerns

Choose the pattern that best fits your complexity requirements and team preferences. The **Pipeline Pattern** is great for linear flows, while the **Graph-Based** approach handles complex dependencies well.