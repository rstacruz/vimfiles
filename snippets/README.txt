example:

```
{
  "name": "personal-snippets",
  "contributes": {
    "snippets": [
      { "language": "lua", "path": "./lua.json" }
      { "language": ["typescriptreact", "javascriptreact"], "path": "./react.json" }
      { "language": "all", "path": "./all.json" }
    ]
  }
}

-- lua.json
{
  "foo": {
    "prefix": "foo",
    "body": [
      "local ${1:foo} = ${2:bar}",
      "return ${3:baz}"
    ]
  }
}
```
