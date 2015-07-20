module MongoCodeGen where
import MongoIR
import Data.List

genCommand :: MongoIR.Command -> String
genCommand (Command id1 id2 items) =
	"db." ++ id1 ++ "." ++ id2 ++ "(" ++ genItems items ++ ");"

genItems :: [Item] -> String
genItems items = intercalate ", " $ map genItem items

genItem :: Item -> String
genItem (LitItem lit) = genLit lit
genItem (ObjItem obj) = genObj obj
genItem (ArrItem arr) = genArr arr

genObj :: Object -> String
genObj obj = "{" ++ (intercalate ", " $ map genPair obj) ++ "}"

genArr :: Array -> String
genArr arr = "[" ++ (intercalate ", " $ map genItem arr) ++ "]"

genLit :: Literal -> String
genLit (Int i) = show i
genLit (String s) = "\"" ++ s ++ "\""

genId :: String -> String
genId id = "\"" ++ id ++ "\""

genPair :: Pair -> String
genPair (Pair id (LitValue lit)) = genId id ++ ": " ++ genLit lit
genPair (Pair id (ObjValue obj)) = genId id ++ ": " ++ genObj obj