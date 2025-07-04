#import "../render.typ": *

/// Default draw node implementation
#let _e-draw-node(from, to, label) = {
  content(
    (0, 0),
    "test",
    name: "cnt",
    angle: -30deg,
  )
}

/// Default draw edge implementation
#let _e-draw-edge(from, to, label) = {}

#let bb-tree(
  list-content,
  draw-edge: _e-draw-edge,
  draw-node: _e-draw-node,
) = {
  import cetz.draw: *
  import cetz.vector: *
  import cetz.tree
  import cetz: *

  let (nodes, edges) = _tree-to-cetz(list-to-tree(list-content))
}
