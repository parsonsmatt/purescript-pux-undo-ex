module Todo.UI where

import Prelude

import Data.Maybe (fromMaybe)
import Data.Int
import Data.Array (length, zip, (..), deleteAt)
import Data.Tuple (Tuple(Tuple))

import Pux
import Pux.Html as H
import Pux.Html ((!), (#), (##))
import Pux.Html.Attributes as A
import Pux.Html.Events as E

data Action
    = Add
    | Update String
    | Remove Int

type State = { current :: String, todos :: Array String }

view :: State -> H.Html Action
view state =
    H.div # do
        H.input ! A.value state.current 
                ! E.onChange (\o -> Update o.target.value) ## []
        H.button ! E.onClick (const Add) # H.text "Add"
        H.ul ## map todoItem (zip (0 .. length state.todos) state.todos)
  where
    bind = H.bind
    todoItem (Tuple i str) = 
        H.li # do
            H.text str
            H.button ! E.onClick (\_ -> Remove i) # H.text "Remove"

update :: Action -> State -> State
update Add state =
    { todos: state.todos ++ [state.current] 
    , current: ""
    }
update (Remove i) state =
    state { todos = fromMaybe state.todos (deleteAt i state.todos) }
update (Update s) state =
    state { current = s }
