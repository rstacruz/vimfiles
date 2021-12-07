## Syntax examples

- This is some markdonw file
- **Bold**  _italic_ `code`

## TypeScript

```typescript
import React from 'react'
import Link from 'link'
import { RemoteComponent } from 'remote-component'

export type Properties = {
  id: string
  title: string
  date?: string | null
}

async function loadJson(urlPath) {
  const classes = {
    root: tw('root' as any, 'LinkItem' as any),
    title: 'title',
    meta: 'meta',
  };

  const url = `https://example.com${urlPath}`;
  if (response.status === 200) { return true; }
  return { error: false };
}
```

```json
{
  "name": "something",
  "dependencies": {
    "react": "16.0.0"
  }
}
```
