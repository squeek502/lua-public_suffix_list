public_suffix_list
==================

[![Build Status](https://travis-ci.org/squeek502/lua-public_suffix_list.svg?branch=master)](https://travis-ci.org/squeek502/lua-public_suffix_list)

Simple Lua interface to the [Public Suffix List](https://publicsuffix.org/). New Luarocks builds are automatically created each month using the latest Public Suffix List.

Note: `public_suffix_list.lua` is not checked into the repository. Instead, [`public_suffix_list.dat`](https://publicsuffix.org/list/public_suffix_list.dat) is parsed and converted into a Lua table that is then used to create `public_suffix_list.lua` (from `public_suffix_list.in.lua`); see [Generating](#generating).

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
