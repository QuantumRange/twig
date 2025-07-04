#import "@preview/cetz:0.4.0"
#import cetz.draw: *
#import cetz.vector: *
#import cetz: *

#let cetz-element-modify(
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

#let cetz-element-modify-name(
  name,
  element-func,
) = {
  cetz-element-modify(element-func, element => {
    element.name = name
    return element
  })
}

#let cetz-body-set-names(
  body,
) = {
  body
    .enumerate()
    .map(((idx, node)) => {
      cetz-element-modify-name("n" + str(idx), node)
    })
    .join()
}

#let cetz-execute(
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

#let cetz-body-analyse(
  body,
) = {
  body = cetz-body-set-names(body)

  cetz.canvas({
    body
    get-ctx(ctx => {
      ctx.groups.push(())

      let (ctx: group-ctx, drawables, bounds) = process.many(ctx, util.resolve-body(ctx, body))

      let children = group-ctx
        .groups
        .last()
        .map(child => {
          let node = group-ctx.nodes.at(child)
          let anchor = node.anchors
          let keys = anchor(())

          (
            name: child,
            drawables: node.drawables,
            anchors: keys
              .map(key => {
                let coord = anchor(key)
                coord = util.revert-transform(group-ctx.transform, coord)
                (str(key): coord)
              })
              .join(),
          )
        })

      content((), [#{
          children
        }])
    })
  })
}
