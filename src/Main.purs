module Main where

import Prelude

import Pux (start, fromSimple, renderToDOM)
import Pux.Html (Html)
import Pux.Undo as Undo

import Todo.UI as UI

view :: Undo.History UI.State -> Html (Undo.Action UI.Action)
view = Undo.simpleView UI.view

main = do
    app <- start
            { initialState: Undo.initialState { current: "enter", todos: ["hello", "friend"] }
             , update: fromSimple (Undo.update UI.update)
             , view: view
             , inputs: []
             }

    renderToDOM "#app" app.html
