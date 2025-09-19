---
layout: post
title:  Angular feature since v16
date:   2025-09-19 11:05
categories: tech 
---

## Major Features in Angular v16

1. **Signals (Developer Preview)**
   - Introduced **Angular Signals**, a new **reactivity model** for state management.
   - Provides fine-grained reactivity similar to frameworks like SolidJS.
   - Helps reduce unnecessary change detection cycles and improves performance.
   - Works seamlessly with existing Angular features (components, templates, etc.).

2. **Hydration for Server-Side Rendering (SSR)**
   - Added **non-destructive hydration** support.
   - Angular apps rendered on the server can now be hydrated on the client without re-rendering the entire DOM.
   - Improves **First Contentful Paint (FCP)** and **Time to Interactive (TTI)**.

3. **Required Inputs**
   - New `@Input({ required: true })` decorator option.
   - Ensures that required inputs are passed when using a component.
   - Improves type safety and developer experience.

4. **Standalone APIs Improvements**
   - Continued push towards **standalone components** (no need for `NgModule`).
   - Router and HttpClient now support standalone APIs out of the box.
   - Simplifies application structure and reduces boilerplate.

5. **Improved Dependency Injection with `inject()`**
   - `inject()` function can now be used in more places (like route guards, resolvers, and interceptors).
   - Makes DI more flexible and tree-shakable.

6. **Enhanced Performance**
   - Optimized reactivity with Signals.
   - Better SSR hydration.
   - Reduced memory usage and faster builds.

7. **Experimental Jest Support**
   - Angular CLI added experimental support for **Jest** as a test runner.
   - Provides faster and more modern testing experience compared to Karma/Jasmine.

8. **ESBuild + Vite Integration (Experimental)**
   - Angular CLI started experimenting with **esbuild** and **Vite** for faster builds and dev server.
   - Aimed at improving developer experience and build performance.

---

✅ **In summary:**  
The **biggest highlight of Angular 16** is the introduction of **Signals** (new reactivity model) and **hydration for SSR**, along with continued improvements for **standalone APIs** and **performance**.


Excellent follow-up! 🚀 Angular **v17** (released November 2023) was another **huge milestone** — in fact, it’s considered one of the **biggest Angular releases in years**.  

Here are the **major features and improvements in Angular 17**:


##  Major Features in Angular v17

### 1. **New Control Flow Syntax (Built-in)**
- Angular introduced a **new, modern control flow syntax** in templates:
  - `@if` / `@else`
  - `@for` (replaces `*ngFor`)
  - `@switch` / `@case` / `@default`
- These are **faster, more ergonomic, and type-safe** compared to the old structural directives.
- Example:
  ```html
  @if (user) {
    <h2>Hello {{ user.name }}</h2>
  } @else {
    <h2>Please log in</h2>
  }

  <ul>
    @for (item of items; track item.id) {
      <li>{{ item.name }}</li>
    }
  </ul>
  ```

---

### 2. **Deferrable Views (`@defer`)**
- New **`@defer` block** allows **lazy loading of template parts**.
- Great for performance optimization (e.g., load heavy components only when needed).
- Example:
  ```html
  @defer (on viewport) {
    <app-heavy-widget />
  } @placeholder {
    <p>Loading widget...</p>
  }
  ```
- Triggers: `on viewport`, `on interaction`, `on hover`, `on idle`, etc.

---

### 3. **Built-in Control Flow & Deferrable Views are Stable**
- These features are **stable and production-ready** in v17 (not experimental anymore).

---

### 4. **New Angular CLI with Vite + esbuild**
- Angular CLI now uses **Vite** (for dev server) and **esbuild** (for builds).
- Benefits:
  - ⚡️ Much faster builds & HMR (Hot Module Replacement).
  - Simpler, modern toolchain.
- Still supports Webpack for backward compatibility.

---

### 5. **Improved SSR & SSG**
- Angular Universal now supports **hybrid rendering**:
  - **SSR (Server-Side Rendering)** + **SSG (Static Site Generation)** in the same app.
- Better hydration performance (building on v16’s hydration work).

---

### 6. **Signals Improvements**
- Signals (introduced in v16) got **deeper framework integration**.
- Router, forms, and other Angular APIs are being updated to work seamlessly with Signals.

---

### 7. **Docs & Learning Experience**
- Angular team launched a **completely redesigned documentation site** with interactive tutorials and modern guides.
- Much easier for beginners and advanced devs alike.

---

## ✅ Summary
Angular v17 is a **transformational release**:
- **New template syntax** (`@if`, `@for`, `@switch`) → cleaner, faster, type-safe.
- **Deferrable views (`@defer`)** → built-in lazy loading for templates.
- **Vite + esbuild in CLI** → faster builds & HMR.
- **SSR + SSG improvements**.
- **Signals integration** continues to expand.
- **New docs** for better learning.

Perfect timing 😃 — Angular **v18** was released in **May 2024**, and it continues the modernization journey that started with v16 and v17.  

Here’s a breakdown of the **major features in Angular v18**:

## Major Features in Angular v18

### 1. **Stable Zoneless Change Detection**
- Angular now officially supports **running without Zone.js** (zoneless mode).
- This was experimental in earlier versions, but in v18 it’s **stable**.
- Benefits:
  - Faster change detection.
  - More predictable reactivity (especially with **Signals**).
  - Smaller bundle size (no Zone.js dependency if you opt out).

---

### 2. **Signals Deep Integration**
- Signals (introduced in v16, improved in v17) are now **deeply integrated** into Angular’s core APIs:
  - **Forms API**: Reactive forms now support Signals.
  - **Router**: Route parameters and data can be exposed as Signals.
  - **Component Inputs**: Inputs can be bound directly to Signals.
- This makes Angular’s reactivity model **consistent and fine-grained**.

---

### 3. **Material 3 (MDC) Updates**
- Angular Material fully embraces **Material Design 3**.
- Includes:
  - Updated components with M3 design tokens.
  - Dynamic color theming.
  - Better accessibility and responsiveness.

---

### 4. **Improved SSR & Hydration**
- Hydration (introduced in v16, improved in v17) is now **default and more robust**.
- Better support for **streaming SSR** and **partial hydration**.
- Hybrid rendering (SSR + SSG) continues to improve.

---

### 5. **CLI & Tooling Enhancements**
- **Vite + esbuild** are now the **default build and dev server pipeline** (Webpack is still supported for migration).
- Faster HMR (Hot Module Replacement).
- Better DX (developer experience) with simplified configs.

---

### 6. **New Developer Tools**
- Angular DevTools updated to support **Signals debugging**.
- Better profiling for zoneless apps.

---

### 7. **Deprecations & Cleanup**
- Some legacy APIs are being deprecated in favor of Signals and modern APIs.
- Continued push towards **standalone components** (NgModules are optional, not required).

---

## ✅ Summary of Angular v18
- **Zoneless change detection is stable** → no more mandatory Zone.js.
- **Signals everywhere** → forms, router, inputs, and more.
- **Material 3** → modern UI with dynamic theming.
- **SSR + Hydration improvements** → faster, more efficient rendering.
- **Vite + esbuild default** → modern, fast build pipeline.
- **Better DevTools** → Signals-aware debugging.

---

👉 So, if we look at the evolution:
- **v16** → Signals (preview), hydration (preview).
- **v17** → New template syntax (`@if`, `@for`, `@defer`), Vite/esbuild (experimental).
- **v18** → Zoneless stable, Signals everywhere, Vite/esbuild default, Material 3.
