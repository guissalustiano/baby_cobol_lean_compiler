import Test.Hspec
import Test.QuickCheck
import Text.Megaparsec (parseMaybe)
import Lib

main :: IO ()
main = hspec $ do
  describe "Parser" $ do
    it "identifier" $ do
      parseMaybe identifier "END" `shouldBe` Just (Identifier "END")
      parseMaybe identifier "N-1" `shouldBe` Just (Identifier "N-1")
      parseMaybe identifier "1a" `shouldBe` Nothing

    it "accept" $ do
        parseMaybe accept "ACCEPT END" `shouldBe` Just (Accept (Identifier "END"))

    it "add" $ do
        parseMaybe add "ADD 1 2 3 TO X" `shouldBe` Just (Add [ALiteral 1, ALiteral 2, ALiteral 3] [Identifier "X"])
        --parseMaybe add "ADD N-1 TO N GIVING CUR" `shouldBe` Just (Add [AIdentifier (Identifier "N-1")] [Identifier "N"])
