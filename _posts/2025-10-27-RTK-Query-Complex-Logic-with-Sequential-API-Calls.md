---
layout: post
title:  RTK Query Complex Logic with Sequential API Calls
date:   2025-10-27 04:56
categories: tech 
---

**system** <sup><kbd><var>2025-10-22T04:59:30Z</var></kbd></sup>:
 You are expert on react.

----


**assistant** <sup><kbd><var>2025-10-25T04:55:02Z</var></kbd></sup>:
 For complex sequential API calls in RTK Query, you have several powerful patterns. Here's how to handle complex dependency chains:

## 1. **Custom Query Function with Sequential Logic**

```javascript
import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react';

export const complexUserApi = createApi({
  reducerPath: 'complexUserApi',
  baseQuery: fetchBaseQuery({ baseUrl: '/api' }),
  tagTypes: ['User'],
  endpoints: (builder) => ({
    registerUserWithDependencies: builder.mutation({
      async queryFn(userData, _api, _extraOptions, baseQuery) {
        try {
          // Step 1: Get encryption token
          const tokenResult = await baseQuery({
            url: '/auth/encryption-token',
            method: 'GET',
          });
          
          if (tokenResult.error) throw tokenResult.error;
          const encryptionToken = tokenResult.data.token;

          // Step 2: Validate business rules
          const validationResult = await baseQuery({
            url: '/validation/business-rules',
            method: 'POST',
            body: userData,
            headers: { 'X-Token': encryptionToken },
          });
          
          if (validationResult.error) throw validationResult.error;

          // Step 3: Check resource availability
          const availabilityResult = await baseQuery({
            url: '/resources/availability',
            method: 'POST',
            body: {
              userData,
              validationId: validationResult.data.id,
            },
          });
          
          if (availabilityResult.error) throw availabilityResult.error;

          // Step 4: Final registration
          const registrationResult = await baseQuery({
            url: '/users/register',
            method: 'POST',
            body: {
              ...userData,
              encryptionToken,
              validationContext: validationResult.data,
              availability: availabilityResult.data,
            },
          });

          return registrationResult;

        } catch (error) {
          return { error };
        }
      },
      invalidatesTags: ['User'],
    }),
  }),
});
```

## 2. **Chained Mutations with Dependent Queries**

```javascript
export const workflowApi = createApi({
  reducerPath: 'workflowApi',
  baseQuery: fetchBaseQuery({ baseUrl: '/api' }),
  tagTypes: ['Workflow'],
  endpoints: (builder) => ({
    // Individual steps as separate mutations
    getEncryptionToken: builder.mutation({
      query: () => ({
        url: '/auth/encryption-token',
        method: 'GET',
      }),
    }),

    validateBusinessRules: builder.mutation({
      query: ({ userData, encryptionToken }) => ({
        url: '/validation/business-rules',
        method: 'POST',
        body: userData,
        headers: { 'X-Token': encryptionToken },
      }),
    }),

    checkResourceAvailability: builder.mutation({
      query: ({ userData, validationId }) => ({
        url: '/resources/availability',
        method: 'POST',
        body: { userData, validationId },
      }),
    }),

    completeRegistration: builder.mutation({
      query: (finalPayload) => ({
        url: '/users/register',
        method: 'POST',
        body: finalPayload,
      }),
      invalidatesTags: ['Workflow'],
    }),

    // Orchestrator mutation that chains everything
    executeRegistrationWorkflow: builder.mutation({
      async queryFn(userData, api, extraOptions, baseQuery) {
        const { dispatch, getState } = api;
        
        try {
          // Execute steps sequentially
          const tokenResult = await dispatch(
            workflowApi.endpoints.getEncryptionToken.initiate()
          ).unwrap();

          const validationResult = await dispatch(
            workflowApi.endpoints.validateBusinessRules.initiate({
              userData,
              encryptionToken: tokenResult.token,
            })
          ).unwrap();

          const availabilityResult = await dispatch(
            workflowApi.endpoints.checkResourceAvailability.initiate({
              userData,
              validationId: validationResult.id,
            })
          ).unwrap();

          const finalResult = await dispatch(
            workflowApi.endpoints.completeRegistration.initiate({
              ...userData,
              encryptionToken: tokenResult.token,
              validationContext: validationResult,
              availability: availabilityResult,
            })
          ).unwrap();

          return { data: finalResult };

        } catch (error) {
          return { error };
        }
      },
    }),
  }),
});
```

## 3. **Conditional Queries with Dependent Data**

```javascript
export const dependentApi = createApi({
  reducerPath: 'dependentApi',
  baseQuery: fetchBaseQuery({ baseUrl: '/api' }),
  tagTypes: ['User'],
  endpoints: (builder) => ({
    // Base queries that can be used independently
    getEncryptionToken: builder.query({
      query: () => '/auth/encryption-token',
    }),

    validateUser: builder.mutation({
      query: ({ userData, encryptionToken }) => ({
        url: '/validation/user',
        method: 'POST',
        body: userData,
        headers: { 'X-Token': encryptionToken },
      }),
    }),

    // Complex mutation that uses previous queries
    registerUserConditional: builder.mutation({
      async queryFn(userData, api, extraOptions, baseQuery) {
        const { getState, dispatch } = api;

        // Check if we already have a token from cache
        const tokenState = getState().dependentApi.queries['getEncryptionToken(undefined)'];
        let encryptionToken;

        if (tokenState?.data?.token) {
          encryptionToken = tokenState.data.token;
        } else {
          // Fetch new token
          const tokenResult = await baseQuery('/auth/encryption-token');
          if (tokenResult.error) return tokenResult;
          encryptionToken = tokenResult.data.token;
        }

        // Proceed with validation and registration
        const validationResult = await baseQuery({
          url: '/validation/user',
          method: 'POST',
          body: userData,
          headers: { 'X-Token': encryptionToken },
        });

        if (validationResult.error) return validationResult;

        // Final registration
        return await baseQuery({
          url: '/users/register',
          method: 'POST',
          body: {
            ...userData,
            encryptionToken,
            validation: validationResult.data,
          },
        });
      },
    }),
  }),
});
```

## 4. **Custom Hook for Complex Workflows**

```javascript
// Custom hook that orchestrates multiple RTK Query calls
export const useComplexRegistration = () => {
  const [executeWorkflow] = workflowApi.useExecuteRegistrationWorkflowMutation();
  const [getToken] = workflowApi.useGetEncryptionTokenMutation();
  const [validate] = workflowApi.useValidateBusinessRulesMutation();
  const [checkAvailability] = workflowApi.useCheckResourceAvailabilityMutation();
  const [complete] = workflowApi.useCompleteRegistrationMutation();

  const executeStepByStep = async (userData) => {
    try {
      // Step 1: Get token
      const tokenResult = await getToken().unwrap();
      
      // Step 2: Validate
      const validationResult = await validate({
        userData,
        encryptionToken: tokenResult.token,
      }).unwrap();
      
      // Step 3: Check availability
      const availabilityResult = await checkAvailability({
        userData,
        validationId: validationResult.id,
      }).unwrap();
      
      // Step 4: Complete registration
      const finalResult = await complete({
        ...userData,
        encryptionToken: tokenResult.token,
        validationContext: validationResult,
        availability: availabilityResult,
      }).unwrap();

      return finalResult;

    } catch (error) {
      throw error;
    }
  };

  return {
    executeWorkflow, // Single mutation approach
    executeStepByStep, // Step-by-step approach
    getToken,
    validate,
    checkAvailability,
    complete,
  };
};
```

## 5. **Advanced Pattern with Error Handling and Progress**

```javascript
export const robustWorkflowApi = createApi({
  reducerPath: 'robustWorkflowApi',
  baseQuery: fetchBaseQuery({ baseUrl: '/api' }),
  tagTypes: ['User'],
  endpoints: (builder) => ({
    registerUserRobust: builder.mutation({
      async queryFn(userData, api, extraOptions, baseQuery) {
        const steps = [];
        const context = {};

        const executeStep = async (stepName, queryConfig, transform = (d) => d) => {
          try {
            steps.push({ name: stepName, status: 'pending' });
            const result = await baseQuery(queryConfig);
            
            if (result.error) {
              steps.find(s => s.name === stepName).status = 'failed';
              throw result.error;
            }
            
            steps.find(s => s.name === stepName).status = 'completed';
            return transform(result.data);
          } catch (error) {
            steps.find(s => s.name === stepName).status = 'failed';
            throw error;
          }
        };

        try {
          // Step 1: Encryption token
          context.encryptionToken = await executeStep(
            'get_encryption_token',
            { url: '/auth/encryption-token' },
            (data) => data.token
          );

          // Step 2: Validation
          context.validation = await executeStep(
            'validate_business_rules',
            {
              url: '/validation/business-rules',
              method: 'POST',
              body: userData,
              headers: { 'X-Token': context.encryptionToken },
            }
          );

          // Step 3: Resource check
          context.availability = await executeStep(
            'check_resource_availability',
            {
              url: '/resources/availability',
              method: 'POST',
              body: {
                userData,
                validationId: context.validation.id,
              },
            }
          );

          // Final step: Registration
          const finalResult = await executeStep(
            'complete_registration',
            {
              url: '/users/register',
              method: 'POST',
              body: {
                ...userData,
                encryptionToken: context.encryptionToken,
                validationContext: context.validation,
                availability: context.availability,
              },
            }
          );

          return { 
            data: { 
              user: finalResult,
              steps,
              context 
            } 
          };

        } catch (error) {
          return { 
            error: {
              ...error,
              steps,
              failedStep: steps.find(s => s.status === 'failed')?.name
            } 
          };
        }
      },
    }),
  }),
});
```

## 6. **Usage in Components**

```javascript
import React from 'react';
import { useComplexRegistration } from './workflowHooks';

const UserRegistration = () => {
  const { executeStepByStep, executeWorkflow } = useComplexRegistration();

  const handleSingleMutation = async (userData) => {
    try {
      const result = await executeWorkflow(userData).unwrap();
      console.log('Registration successful:', result);
    } catch (error) {
      console.error('Registration failed:', error);
    }
  };

  const handleStepByStep = async (userData) => {
    try {
      const result = await executeStepByStep(userData);
      console.log('Step-by-step registration successful:', result);
    } catch (error) {
      console.error('Step-by-step registration failed:', error);
    }
  };

  return (
    <div>
      <button onClick={() => handleSingleMutation(userData)}>
        Register (Single Mutation)
      </button>
      <button onClick={() => handleStepByStep(userData)}>
        Register (Step by Step)
      </button>
    </div>
  );
};
```

## Key Benefits of RTK Query Approach:

1. **Automatic Caching** - Individual steps can be cached
2. **Built-in Loading States** - Each mutation provides loading states
3. **Error Handling** - Comprehensive error handling out of the box
4. **Optimistic Updates** - Can implement optimistic updates
5. **Cache Invalidation** - Automatic cache management
6. **DevTools Integration** - Full Redux DevTools support
7. **TypeScript Support** - Excellent TypeScript integration

Choose the pattern based on your needs:
- **Custom Query Function** for simple sequential flows
- **Chained Mutations** for reusable, testable steps
- **Custom Hooks** for complex UI orchestration
- **Robust Pattern** for production-grade error handling