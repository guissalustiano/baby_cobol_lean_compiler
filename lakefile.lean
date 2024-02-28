import Lake
open Lake DSL

--package «baby_cobol» where
  -- add package configuration options here

--lean_lib «BabyCobol» where
  -- add library configuration options here

@[default_target]
lean_exe «baby_cobol» where
  root := `Main


require std from git
  "https://github.com/leanprover/std4" @ "main"

require Parser from git
  "https://github.com/fgdorais/lean4-parser" @ "main"
