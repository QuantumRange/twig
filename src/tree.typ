/// Converts a list into a tree structure.
///
/// ```
/// list-to-tree([
/// - root node
///   - one child
///   / edge label: another child
/// ])
/// ```
///
/// The above call returns:
/// ```
/// (
///   node-label: [root node],
///   edge-label: none,
///   children: (
///     (
///       node-label: [one child],
///       edge-label: none,
///       children: ()
///     ),
///     (
///       node-label: [another child],
///       edge-label: [edge label],
///       children: ()
///     )
///   )
/// )
/// ```
///
/// - body (content): A list
/// -> A dictionary

#let list-to-tree(body) = {
  let helper(element) = {
    let node = if element.has("body") { element.body } else { element.description }

    let elements = if not node.has("children") {
      (node,)
    } else {
      node.children.filter(v => v.fields().len() != 0)
    }

    let root = elements.first()
    let children = elements.slice(1).filter(v => v.has("body") or v.has("term"))

    (
      node-label: root,
      edge-label: element.at("term", default: none),
      children: children.map(helper),
    )
  }

  let items = body.children.filter(v => v.has("body"))

  if items.len() == 0 {
    return ()
  }

  let firstItem = items.first()

  helper(firstItem)
}


#let _tree-to-cetz(tree) = {
  let helper(key, tree) = {
    let children = tree.children.enumerate().map(((idx, child)) => helper(key + "-" + str(idx), child))

    (
      nodes: (tree.node-label,) + children.map(v => v.nodes),
      edges: children
        .enumerate()
        .map(((idx, child)) => {
          (key + "-" + str(idx): tree.children.at(idx).edge-label)
          child.edges
        })
        .join(),
    )
  }

  helper("g0", tree)
}
