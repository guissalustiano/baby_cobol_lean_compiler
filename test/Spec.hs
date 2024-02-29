import Test.Hspec
import Test.QuickCheck
import Text.Megaparsec (parseMaybe)
import Lib

main :: IO ()
main = hspec $ do
  describe "Parser" $ do
    it "identifier" $ do
      parseMaybe identifier "a" `shouldBe` Just (Identifier "a")
      parseMaybe identifier "a1" `shouldBe` Just (Identifier "a1")
      parseMaybe identifier "a_" `shouldBe` Just (Identifier "a_")
      parseMaybe identifier "_1" `shouldBe` Just (Identifier "_1")
      parseMaybe identifier "1a" `shouldBe` Nothing
