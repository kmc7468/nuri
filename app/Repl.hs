module Repl where

import           System.IO                                ( hFlush )

import           Control.Lens
import           Control.Lens.TH                          ( )

import qualified Data.Map                      as M
import           Data.Text                                ( strip )

import           Text.Megaparsec

import           Nuri.Eval.Stmt
import           Nuri.Eval.Expr
import           Nuri.Expr
import           Nuri.Eval.Val
import           Nuri.Parse.Stmt

data ReplState = ReplState { _prompt :: Text, _replSymbolTable :: SymbolTable, _fileName :: Text }

$(makeLenses ''ReplState)

newtype Repl a = Repl { unRepl :: StateT ReplState IO a }
  deriving (Monad, Functor, Applicative, MonadState ReplState, MonadIO)

intrinsicTable :: SymbolTable
intrinsicTable = M.fromList
  [ ( "보여주다"
    , makeFunc
      pos
      ["값"]
      (do
        result <- evalExpr (Var pos "값")
        putTextLn $ printVal result
        return (Normal Undefined)
      )
    )
  ]
  where pos = initialPos "내장"

evalInput :: Text -> Repl (Maybe (Flow Val))
evalInput input = do
  st <- get
  case runParser (parseStmts <* eof) (toString $ view fileName st) input of
    Left err -> do
      liftIO $ (putTextLn . toText . errorBundlePretty) err
      return Nothing
    Right parseResult -> do
      evalResult <- liftIO $ runStmtsEval
        parseResult
        (InterpreterState (view replSymbolTable st) False)
      case evalResult of
        Left evalErr -> do
          liftIO $ print evalErr
          return Nothing
        Right (evalValue, st') -> do
          modify $ set replSymbolTable (view symbolTable st')
          return $ Just evalValue

repl :: Repl ()
repl = forever $ do
  st <- get
  liftIO $ do
    putText (view prompt st)
    hFlush stdout
  input <- strip <$> liftIO getLine
  liftIO $ when (input == ":quit") exitSuccess
  result <- evalInput input
  case result of
    Just val -> liftIO $ print val
    Nothing  -> pass

runRepl :: Repl a -> ReplState -> IO ()
runRepl f st = void $ runStateT (unRepl f) st
