public_suffix_list
==================

Simple Lua interface to the [Public Suffix List](https://publicsuffix.org/)

```lua
local public_suffix_list = require('public_suffix_list')

if public_suffix_list.exists('com') then
  -- ...
end
```

## Installation
With [Luarocks](https://luarocks.org):
```
luarocks install public_suffix_list
```

## Generating
- Download `public_suffix_list.dat` from [here](https://publicsuffix.org/list/public_suffix_list.dat) or [here](https://raw.githubusercontent.com/publicsuffix/list/HEAD/public_suffix_list.dat)
- Run `lua generate.lua`

## API Reference

### `public_suffix_list.exists(suffix)`
Checks if the suffix rule exists (can be any type). On success, returns `true`; otherwise, returns `false`.

### `public_suffix_list.getType(suffix)`
Returns the type of the suffix rule (as a lowercase string) if it exists (e.g. `"icann"` or `"private"`); othwerwise, returns `nil, errmsg`.

### `public_suffix_list.isICANN(suffix)`
Returns `true` if the suffix rule is delegated by ICANN; otherwise, returns `false`.

### `public_suffix_list.isPrivate(suffix)`
Returns `true` if the suffix rule is submitted by a domain holder; otherwise, returns `false`.

### `public_suffix_list.rules`
A table of `key, value` pairs where `key` is a suffix rule type (as a lowercase string, e.g. `"icann"`) and `value` is an array-like table of suffix rules.
