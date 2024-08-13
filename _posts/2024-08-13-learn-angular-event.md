---
layout: post
title:  learn angular - event
date:   2024-08-13 01:45
categories: tech 
---

1. child to parent comunication with event using @Output

```ts
import {Component, Output, EventEmitter} from '@angular/core';

@Component({
  selector: 'app-child',
  styles: `.btn { padding: 5px; }`,
  template: `
    <button class="btn" (click)="addItem()">Add Item</button>
  `,
  standalone: true,
})
export class ChildComponent {
  @Output() addItemEvent = new EventEmitter<string>();

  addItem() {
      this.addItemEvent.emit('🐢');
  }
}
```

'🐢' is emited by child component

```ts
import {Component} from '@angular/core';
import {ChildComponent} from './child.component';

@Component({
  selector: 'app-root',
  template: `
    <app-child (addItemEvent)="addItem($event)" />
      {{ items }}
    <p>🐢 all the way down {{ items.length }}</p>
  `,
  standalone: true,
  imports: [ChildComponent],
})
export class AppComponent {
  items = new Array();

  addItem(item: string) {
    this.items.push(item);
  }
}
```

'🐢' is emitted in child and become the `$event`.
