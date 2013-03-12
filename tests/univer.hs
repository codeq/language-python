import Language.Python.Common.Pretty (prettyText)
import Language.Python.Common.PrettyAST
import Language.Python.Univer.Parser (parseStmt)
import Test.Framework (defaultMain, testGroup)
import Test.Framework.Providers.HUnit
import Test.HUnit

tests = [
  testCase "simple assignment" (testF
    "x = 'a'\n"
    ),

  testGroup "print statement" [
    testCase "python 2 simple syntax" (testF
      "print 'hello, world'\n"
      ),
    testCase "python 2 comma-separated values" (testF
      "print a, b, c\n"
      ),
    testCase "python 2 redirected output" (testF
      "print >> sys.stderr, 'abc'\n"
      ),
    testCase "python 3 simple syntax" (testF
      "print(a, b, c)\n"
      ),
    testCase "python 3 keyword arguments" (testF
      "print(a, b, sep=';')\n"
      )
    ]
  ]

main = defaultMain tests

testF fixture
  = pretty (pretty fixture) @?= pretty fixture
  where
    pretty = unlines . map prettyText . stmts
    stmts fixture = case parseStmt fixture "test.py" of
      Left e -> error $ show e
      Right (s, _) -> s
