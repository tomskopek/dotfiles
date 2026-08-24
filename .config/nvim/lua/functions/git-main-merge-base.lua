-- Resolve the merge-base between HEAD and the repo's main branch.
-- This is the right base for answering "what did this branch change" diffs
-- (same semantics as a GitHub PR diff: commits that happened on main since git-branching do not show up)
--
-- Tries origin/main, origin/master, main, master, so it works in repos with
-- either naming and with or without a remote.
--
-- Returns sha, ref — or nil if no candidate branch exists.
return function(cwd)
  for _, ref in ipairs({ "origin/main", "origin/master", "main", "master" }) do
    local obj = vim.system({ "git", "merge-base", ref, "HEAD" }, { cwd = cwd, text = true }):wait()
    if obj.code == 0 then
      return vim.trim(obj.stdout), ref
    end
  end
  return nil
end
