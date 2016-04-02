module Main where

import Prelude

import Pux (start, fromSimple, renderToDOM)
import Pux.Html (Html)
import Pux.Undo as Undo

import Todo.UI as UI

main = do
    app <- start
            { initialState: Undo.initialState { current: "enter", todos: ["hello", "friend"] }
             , update: fromSimple (Undo.update UI.update)
             , view: Undo.simpleView UI.view
             , inputs: []
             }

    renderToDOM "#app" app.html
