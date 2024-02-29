import Parser

namespace BabyCobol

open Parser Char

abbrev Parser := SimpleParser Substring Char


/-- Parse JSON white spaces -/
def ws : BabyCobol.Parser Unit := dropMany <| tokenFilter fun c => c == ' ' || c == '\n' || c == '\r' || c == '\t'

def tbatata: BabyCobol.Parser String := do
  let _ ← ws
  let s ← string "batata"
  let _ ← ws
  return s

def const {α : Type} {β: Type} (a: α): β → α := fun _ => a

#eval const 1 2
#check const 1 <$> tbatata
#eval const 1 <$> tbatata


end BabyCobol
