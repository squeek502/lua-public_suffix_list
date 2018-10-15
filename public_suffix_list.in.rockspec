package = "public_suffix_list"
version = "%VERSION%-%VER_LUAROCKS_REV%"
source = {
   url = "https://github.com/squeek502/lua-public_suffix_list/releases/download/v%VER_TAG%/public_suffix_list-%VERSION%.tar.gz"
}
description = {
   detailed = "Lua interface to the Public Suffix List",
   homepage = "https://github.com/squeek502/lua-public_suffix_list",
   license = "Unlicense"
}
dependencies = {
   "lua >= 5.1"
}
build = {
   type = "builtin",
   modules = {
     public_suffix_list = "public_suffix_list.lua",
   },
}
