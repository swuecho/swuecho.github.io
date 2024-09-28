---
layout: post
title:  Best Approach to Style React Component
date:   2024-09-28 07:18
categories: tech 
---

There are two categories.

### 1. style in the same file

**React-JSS**
**Styled Components with Emotion/Styled**
**@mui/system**
**Tailwind**

### 2. style in the different file

**CSS/SASS**, easy to accidently polute the global css class. If it is chosen, follow the [BEM](https://css-tricks.com/bem-101/)

**CSS Modules**, I think it is quite good.

I like the everything in one file solultion, so three are left.

**React-JSS** : Not in active development. I actualy like to use it. feels straight forward. not much cognitive load.

**Styled Components with Emotion/Styled**: It is good to write custom component based on @mui/material

**Tailwind**: quite good, only disadvantage is you have to config the build pipeline.

**@mui/system**: The example given by LLM is still using mui/system. It is actually in the same level with tailwind css.

In the company I worked. They have a internal design system based on @mui/material. The best approach is to use the internal component and compose the component with @mui/system.

For most developer, if you use a component library, a light weight css framework like tailwind is good (mui/system in the same niche). The libray or framework you use is decided by the work.


## LLM's example

Sure! Below is a simple "Todo App" implemented in React using each of the five styling approaches: **React-JSS**, **Styled Components with Emotion/Styled**, **@mui/system**, **CSS/SASS**, and **CSS Modules**.

### 1. **Todo App with React-JSS**

```jsx
import React, { useState } from 'react';
import { createUseStyles } from 'react-jss';

const useStyles = createUseStyles({
  container: {
    fontFamily: 'Arial, sans-serif',
    maxWidth: '400px',
    margin: '0 auto',
    padding: '20px',
    border: '1px solid #ccc',
    borderRadius: '5px',
  },
  input: {
    width: '100%',
    padding: '10px',
    marginBottom: '10px',
    borderRadius: '5px',
    border: '1px solid #ccc',
  },
  list: {
    listStyle: 'none',
    padding: '0',
  },
  listItem: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: '10px',
    borderBottom: '1px solid #ccc',
    '&:last-child': {
      borderBottom: 'none',
    },
  },
  button: {
    backgroundColor: '#ff6347',
    color: 'white',
    border: 'none',
    padding: '5px 10px',
    borderRadius: '5px',
    cursor: 'pointer',
  },
});

const TodoApp = () => {
  const classes = useStyles();
  const [todos, setTodos] = useState([]);
  const [input, setInput] = useState('');

  const addTodo = () => {
    if (input.trim()) {
      setTodos([...todos, input]);
      setInput('');
    }
  };

  const deleteTodo = (index) => {
    const newTodos = todos.filter((_, i) => i !== index);
    setTodos(newTodos);
  };

  return (
    <div className={classes.container}>
      <input
        className={classes.input}
        type="text"
        value={input}
        onChange={(e) => setInput(e.target.value)}
        onKeyPress={(e) => e.key === 'Enter' && addTodo()}
      />
      <ul className={classes.list}>
        {todos.map((todo, index) => (
          <li key={index} className={classes.listItem}>
            {todo}
            <button className={classes.button} onClick={() => deleteTodo(index)}>
              Delete
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default TodoApp;
```

### 2. **Todo App with Styled Components (Emotion/Styled)**

```jsx
import React, { useState } from 'react';
import styled from '@emotion/styled';

const Container = styled.div`
  font-family: Arial, sans-serif;
  max-width: 400px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
`;

const Input = styled.input`
  width: 100%;
  padding: 10px;
  margin-bottom: 10px;
  border-radius: 5px;
  border: 1px solid #ccc;
`;

const List = styled.ul`
  list-style: none;
  padding: 0;
`;

const ListItem = styled.li`
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
  border-bottom: 1px solid #ccc;
  &:last-child {
    border-bottom: none;
  }
`;

const Button = styled.button`
  background-color: #ff6347;
  color: white;
  border: none;
  padding: 5px 10px;
  border-radius: 5px;
  cursor: pointer;
`;

const TodoApp = () => {
  const [todos, setTodos] = useState([]);
  const [input, setInput] = useState('');

  const addTodo = () => {
    if (input.trim()) {
      setTodos([...todos, input]);
      setInput('');
    }
  };

  const deleteTodo = (index) => {
    const newTodos = todos.filter((_, i) => i !== index);
    setTodos(newTodos);
  };

  return (
    <Container>
      <Input
        type="text"
        value={input}
        onChange={(e) => setInput(e.target.value)}
        onKeyPress={(e) => e.key === 'Enter' && addTodo()}
      />
      <List>
        {todos.map((todo, index) => (
          <ListItem key={index}>
            {todo}
            <Button onClick={() => deleteTodo(index)}>Delete</Button>
          </ListItem>
        ))}
      </List>
    </Container>
  );
};

export default TodoApp;
```

### 3. **Todo App with @mui/system**

```jsx
import React, { useState } from 'react';
import { Box, TextField, List, ListItem, ListItemText, Button } from '@mui/material';
import { styled } from '@mui/system';

const StyledBox = styled(Box)({
  fontFamily: 'Arial, sans-serif',
  maxWidth: '400px',
  margin: '0 auto',
  padding: '20px',
  border: '1px solid #ccc',
  borderRadius: '5px',
});

const StyledTextField = styled(TextField)({
  width: '100%',
  marginBottom: '10px',
});

const StyledButton = styled(Button)({
  backgroundColor: '#ff6347',
  color: 'white',
  border: 'none',
  padding: '5px 10px',
  borderRadius: '5px',
  cursor: 'pointer',
});

const TodoApp = () => {
  const [todos, setTodos] = useState([]);
  const [input, setInput] = useState('');

  const addTodo = () => {
    if (input.trim()) {
      setTodos([...todos, input]);
      setInput('');
    }
  };

  const deleteTodo = (index) => {
    const newTodos = todos.filter((_, i) => i !== index);
    setTodos(newTodos);
  };

  return (
    <StyledBox>
      <StyledTextField
        variant="outlined"
        value={input}
        onChange={(e) => setInput(e.target.value)}
        onKeyPress={(e) => e.key === 'Enter' && addTodo()}
      />
      <List>
        {todos.map((todo, index) => (
          <ListItem key={index}>
            <ListItemText primary={todo} />
            <StyledButton onClick={() => deleteTodo(index)}>Delete</StyledButton>
          </ListItem>
        ))}
      </List>
    </StyledBox>
  );
};

export default TodoApp;
```

### 4. **Todo App with CSS/SASS**

**TodoApp.css:**

```css
.container {
  font-family: Arial, sans-serif;
  max-width: 400px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.input {
  width: 100%;
  padding: 10px;
  margin-bottom: 10px;
  border-radius: 5px;
  border: 1px solid #ccc;
}

.list {
  list-style: none;
  padding: 0;
}

.listItem {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
  border-bottom: 1px solid #ccc;
}

.listItem:last-child {
  border-bottom: none;
}

.button {
  background-color: #ff6347;
  color: white;
  border: none;
  padding: 5px 10px;
  border-radius: 5px;
  cursor: pointer;
}
```

**TodoApp.js:**

```jsx
import React, { useState } from 'react';
import './TodoApp.css';

const TodoApp = () => {
  const [todos, setTodos] = useState([]);
  const [input, setInput] = useState('');

  const addTodo = () => {
    if (input.trim()) {
      setTodos([...todos, input]);
      setInput('');
    }
  };

  const deleteTodo = (index) => {
    const newTodos = todos.filter((_, i) => i !== index);
    setTodos(newTodos);
  };

  return (
    <div className="container">
      <input
        className="input"
        type="text"
        value={input}
        onChange={(e) => setInput(e.target.value)}
        onKeyPress={(e) => e.key === 'Enter' && addTodo()}
      />
      <ul className="list">
        {todos.map((todo, index) => (
          <li key={index} className="listItem">
            {todo}
            <button className="button" onClick={() => deleteTodo(index)}>
              Delete
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default TodoApp;
```

### 5. **Todo App with CSS Modules**

**TodoApp.module.css:**

```css
.container {
  font-family: Arial, sans-serif;
  max-width: 400px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.input {
  width: 100%;
  padding: 10px;
  margin-bottom: 10px;
  border-radius: 5px;
  border: 1px solid #ccc;
}

.list {
  list-style: none;
  padding: 0;
}

.listItem {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
  border-bottom: 1px solid #ccc;
}

.listItem:last-child {
  border-bottom: none;
}

.button {
  background-color: #ff6347;
  color: white;
  border: none;
  padding: 5px 10px;
  border-radius: 5px;
  cursor: pointer;
}
```

**TodoApp.js:**

```jsx
import React, { useState } from 'react';
import styles from './TodoApp.module.css';

const TodoApp = () => {
  const [todos, setTodos] = useState([]);
  const [input, setInput] = useState('');

  const addTodo = () => {
    if (input.trim()) {
      setTodos([...todos, input]);
      setInput('');
    }
  };

  const deleteTodo = (index) => {
    const newTodos = todos.filter((_, i) => i !== index);
    setTodos(newTodos);
  };

  return (
    <div className={styles.container}>
      <input
        className={styles.input}
        type="text"
        value={input}
        onChange={(e) => setInput(e.target.value)}
        onKeyPress={(e) => e.key === 'Enter' && addTodo()}
      />
      <ul className={styles.list}>
        {todos.map((todo, index) => (
          <li key={index} className={styles.listItem}>
            {todo}
            <button className={styles.button} onClick={() => deleteTodo(index)}>
              Delete
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default TodoApp;
```

### Summary

Each approach has its own strengths and weaknesses:

- **React-JSS** and **Styled Components with Emotion/Styled** are ideal for dynamic styles and theming, especially when you want to write styles directly within your JavaScript/TypeScript files.
- **@mui/system** is best suited for projects that use Material-UI components and need responsive design and theming capabilities.
- **CSS/SASS** is a good choice for traditional styling with static styles and a separation of concerns.
- **CSS Modules** is a middle ground between traditional CSS and scoped styles, ideal for projects that want to avoid CSS conflicts without adopting a full CSS-in-JS solution.