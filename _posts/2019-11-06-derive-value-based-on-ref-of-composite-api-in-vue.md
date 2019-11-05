---
layout: post
title:  derive value based on ref of composite api in vue 
date:   2019-11-06 00:42 
categories: tech 
---

## use computed to derive new value based the fetch data


```javascript
    const { loading, tableData } = useAdminFetch(uri) // how to watch the fetch value
    // computed value based on the useFunc
    const rowData = computed(() => tableData.value.map(x => x.json))
    const columnDefs = computed(() => {
      if (rowData.value[0]) {
        let header = Object.keys(rowData.value[0])
        return header.map(x => ({
          headerName: x,
          field: x
        }))
      }
      return []
    })
    return { loading, rowData, columnDefs }
```

In the script, rowData and columnDefs are derived from tableData. `computed` is the right api to use.
