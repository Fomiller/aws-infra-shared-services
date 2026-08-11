exclude {
  if      = true
  actions = ["all"]
}

include "root" {
	path = find_in_parent_folders("root.hcl")
}
