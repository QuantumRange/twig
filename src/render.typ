#import "tree.typ": *
#import "@preview/cetz:0.4.0"

#let _default-draw-edge(from, to, ..) = {
  import cetz.draw: *
  line((from + ".center", 0.4, to + ".center"), (to + ".center", 0.4, from + ".center"))
}

#let _default-draw-edge-label(from, to, label, ..) = {
  import cetz.draw: *
  import cetz.vector: *
  group(ctx => {
    let (a, b) = (from + ".center", to + ".center")
    let (_, abs-from, abs-to) = cetz.coordinate.resolve(ctx, a, b)

    content(
      (a, 50%, b),
      anchor: "south",
      angle: if sub(abs-to, abs-from).at(0) < 0 { from } else { to },
      padding: 0.1,
      label,
    )
  })
}



/// Given a tree in the following node format:
/// ```
/// (
///   node-label: content,
///   edge-label: content,
///   children: array (of nodes)
/// )
/// ```
/// this function uses cetz.tree to draw a tree WITH edge labels.
///
/// - rep (dictionary): the tree in the above specified format.
/// - draw-edge (function): (from: cetz anchor, to: cetz anchor, ..args) draws the node using cetz.
/// - draw-edge-label (function): (from: cetz anchor, to: cetz anchor, label: content | none, ..args) draws the edge using cetz.
/// - args (argument): the arguments for the cetz.tree function.
/// -> none
#let tree-to-cetz(
  rep,
  draw-edge: _default-draw-edge,
  draw-edge-label: _default-draw-edge-label,
  ..args,
) = {
  import cetz.draw: *
  import cetz.vector: *
  import cetz.tree

  let (nodes, edges) = _tree-to-cetz(rep)

  tree.tree(nodes, ..args, draw-edge: (from, to, ..args2) => {
    draw-edge(from, to, ..args2)
    draw-edge-label(from, to, edges.at(to), ..args2)
  })
}
