#import "@preview/cetz:0.4.0"
#import "bb.typ" as bb
#import cetz.draw: *
#import cetz.vector: *
#import cetz: *

#let element-modify(
  element-func,
  apply,
) = {
  (
    ctx => {
      let element-func = if type(element-func) == array {
        assert(element-func.len() == 1, message: "Only one function!")

        element-func.at(0)
      } else {
        element-func
      }

      let element = element-func(ctx)

      return apply(element)
    },
  )
}

#let body-evaluate(
  body,
) = {
  // This isn't nice but it works for now
  let ctx = (
    version: cetz.version,
    length: length,
    debug: false,
    background: none,
    prev: (pt: (0.0, 0.0, 0.0)),
    style: styles.default,
    transform: (
      (1.0, 0.0, -0.5, 0.),
      (0.0, -1.0, +0.5, 0.),
      (0.0, 0.0, 1.0, 0.),
      (0.0, 0.0, 0.0, 1.),
    ),
    nodes: (:),
    groups: (),
    marks: (
      mnemonics: (:),
      marks: (:),
    ),
    resolve-coordinate: (),
    shared-state: (:),
  )

  return process.many(ctx, util.resolve-body(ctx, body))
}

#let body-analyse(
  body,
) = {
  // I don't see any nodes in ctx except when they have names, so this is my very normal solution
  body = body
    .enumerate()
    .map(((idx, node)) => {
      element-modify(node, element => {
        element.name = "n" + str(idx)
        return element
      })
    })
    .join()

  let (ctx, drawables, bounds) = body-evaluate(body)

  let nodes = ctx
    .nodes
    .values()
    .map(node => {
      let anchor = node.anchors
      let anchor-keys = anchor(())

      (
        name: node.name,
        anchors: anchor-keys
          .map(key => {
            let coord = anchor(key)

            coord = util.revert-transform(ctx.transform, coord)

            (str(key): coord)
          })
          .join(),
      )
    })

  nodes = nodes.map(node => node + (bb: bb.calculate-bb(node)))

  nodes
}
