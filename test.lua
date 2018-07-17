local psl = require('public_suffix_list')

assert(psl.exists("com"))
assert(psl.exists("blogspot.com"))
assert(not psl.exists("comcom"))

assert(psl.getType("com") == "icann")
assert(psl.getType("blogspot.com") == "private")
assert(psl.getType("comcom") == nil)

assert(psl.isICANN("com"))
assert(not psl.isPrivate("com"))
assert(psl.isPrivate("blogspot.com"))
assert(not psl.isICANN("blogspot.com"))
assert(not psl.isICANN("comcom"))
assert(not psl.isPrivate("comcom"))

print("All tests passed")
