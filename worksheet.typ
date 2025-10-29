// Formatting Constants.
#let FONT_NAME = "IBM Plex Mono"
#let FONT_SIZE = 3pt
#let PAPER_TYPE = "us-letter"
#let MARGIN_SIZE = 0.25in
#let STROKE_COLOR = rgb("#6e6e6e")
#let LINE_HEIGHT = 14pt
#let LINE_GAP = 12pt
#let NUM_LINE_COLUMNS = 3
#let NUM_CHARACTERS = 8
#let NUM_DAMAGE_ROWS = 12

#let helper_text(t) = {
  let t = text(
    font: FONT_NAME,
    size: FONT_SIZE,
  )[#t]
  let p = place(
    top + left,
    dx: 2pt,
    dy: 1pt,
    t,
  )
  return p
}

#let helper_text_justified(t) = {
  let tb = text(
    font: FONT_NAME,
    size: FONT_SIZE,
    spacing: 9pt,
  )[#t]
  let pab = par(justify: true)[#tb]
  let plb = place(
    top + center,
    dy: 1pt,
    pab,
  )
  return plb
}

#let grid_cell(x, y, b, ..extras) = {
  return grid.cell(
    x: x,
    y: y,
    ..extras
  )[#b]
}

#let page_settings = (
  paper: PAPER_TYPE,
  flipped: true,
  margin: (x: MARGIN_SIZE, y: MARGIN_SIZE),
)

#page(..page_settings)[
  #{
    // Inputs.
    let section_width = 5
    let label_row_quantity = 7
    let cell_height = 17.5pt
    
    // Computed properties.
    let column_count = section_width * NUM_CHARACTERS
    let row_count = label_row_quantity + NUM_DAMAGE_ROWS

    // Grid height / width.
    let rows = ()
    for i in range(label_row_quantity) {
      rows.push(cell_height + 1pt) // Rows with labels are taller.
    }
    for i in range(NUM_DAMAGE_ROWS) {
      rows.push(cell_height)
    }
    
    let columns = ()
    for i in range(column_count) {
      columns.push(1fr)
    }

    // Track grid cells and row/col postion.
    let cells = ()
    let x = 0
    let y = 0
    
    // Row 0.
    for i in range(NUM_CHARACTERS) {
      let t1 = helper_text("+DEX")
      let c1 = grid_cell(x, y, t1)
      cells.push(c1)
      x = x + 1

      let t2 = helper_text("Initiative")
      let c2 = grid_cell(x, y, t2, colspan: 3)
      cells.push(c2)
      x = x + 3

      let t3 = helper_text("Order")
      let c3 = grid_cell(x, y, t3, stroke: 0.75pt)
      cells.push(c3)
      x = x + 1
    }
    // At the end of each row reset column position
    // and increment row position.
    x = 0
    y = y + 1

    // Row 1.
    for i in range(NUM_CHARACTERS) {
      let l4 = helper_text("Name")
      let c4 = grid_cell(x, y, l4, colspan: 2)
      cells.push(c4)
      x = x + 2

      let l5 = helper_text("Spell Attack Bonus / Save DC")
      let c5 = grid_cell(x, y, l5, colspan: 3)
      cells.push(c5)
      x = x + 3
    }
    x = 0
    y = y + 1

    // Row 2.
    for i in range(NUM_CHARACTERS) {
      let l6 = helper_text_justified("STR DEX CON INT WIS CHA")
      let c6 = grid_cell(x, y, l6, colspan: 5)
      cells.push(c6)
      x = x + 5
    }
    x = 0
    y = y + 1

    // Row 3.
    for i in range(NUM_CHARACTERS) {
      let l7 = helper_text("Attacks / Abilities")
      let c7 = grid_cell(x, y, l7, colspan: 5, rowspan: 3)
      cells.push(c7)
      x = x + 5
    }
    y = y + 3
    x = 0

    // Row 4.
    for j in range(NUM_CHARACTERS) {
      let l8 = helper_text("Armor Class")
      let c8 = grid_cell(x, y, l8, colspan: 2, stroke: 0.75pt)
      cells.push(c8)
      x = x + 2

      let l9 = helper_text("Hit Points")
      let c9 = grid_cell(x, y, l9, colspan: 3)
      cells.push(c9)
      x = x + 3
    }
    y = y + 1
    x = 0

    // Row 5.
    for j in range(NUM_CHARACTERS) {
      let l9 = helper_text("Damage")
      let c9 = grid_cell(x, y, l9, colspan: 2)
      cells.push(c9)
      x = x + 2

      let c10 = grid_cell(x, y, [], colspan: 3)
      cells.push(c10)
      x = x + 3
    }
    y = y + 1
    x = 0

    // Rows 6 - 18.
    for i in range(NUM_DAMAGE_ROWS) {
      for j in range(NUM_CHARACTERS) {
        let c11 = grid_cell(x, y, [], colspan: 2)
        cells.push(c11)
        x = x + 2

        let c12 = grid_cell(x, y, [], colspan: 3)
        cells.push(c12)
        x = x + 3
      }
      y = y + 1
      x = 0
    }

    grid(
      rows: rows,
      columns: columns,
      stroke: 0.5pt + STROKE_COLOR,
      align: center + horizon,
      ..cells,
    )

    // Draw three columns of repeated lines.
    let line = line(
      start: (0%, 0%), 
      end: (100%, 0%), 
      stroke: 0.5pt + STROKE_COLOR,
    )

    let line_pattern = tiling(
      size: (1pt, LINE_HEIGHT)
    )[#line]

    let rects = ()
    for i in range(NUM_LINE_COLUMNS) {
      let r = rect(
        fill: line_pattern,
        width: 100%,
        height: 100%
      )
      rects.push(r)
    }

    block(height: 1fr, width: 100%)[
      #grid(
        columns: NUM_LINE_COLUMNS,
        rows: (auto),
        gutter: LINE_GAP,
        ..rects,
      )
    ]
  }

]
