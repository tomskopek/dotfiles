-- Case coercion (and smarter substitution).
--
-- Coerce the word under the cursor:
--   crs  snake_case
--   crc  camelCase
--   crm  MixedCase (PascalCase)
--   cru  SNAKE_UPPERCASE
--   cr-  dash-case
--   cr.  dot.case
--
-- Bonus: :Subvert/child{,ren}/adult{,s}/g  -- substitution that handles
-- case variants (child/Child/CHILD) and word forms in one pass.

return {
  {
    "tpope/vim-abolish",
  },
}
