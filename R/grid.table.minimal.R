#' Title
#'
#' @param table
#' @param row
#' @param col
#' @param name
#'
#' @return
#' @export
#'
#' @examples
find_cell <- function(table, row, col, name="core-fg"){
  l <- table$layout
  which((l$t %in% row) & (l$l %in% col) & (l$name %in% name))
}
#' Title
#'
#' @param g
#' @param col
#' @param name
#'
#' @return
#' @export
#'
#' @examples
find_col <- function(g, col, name="core-fg"){
  l <- g$layout
  which((l$l %in% col) & (l$name %in% name))
}
#' Title
#'
#' @param g
#' @param row
#' @param name
#'
#' @return
#' @export
#'
#' @examples
find_row <- function(g, row, name="core-fg"){
  l <- g$layout
  which((l$t %in% row) & (l$name %in% name))
}

#' Title
#'
#' @param g
#' @param rows
#' @param gp
#' @param l
#' @param r
#' @param pos
#'
#' @return
#' @export
#'
#' @examples
gtable_add_hline <- function(
    g,
    rows,
    gp = gpar(col = "black", lwd = 1),
    l = 1,
    r = ncol(g),
    pos = 0){

  line.grob <- linesGrob(x = unit(c(0, 1), "npc"),
                         y = unit(pos, "npc"),
                         gp = gp)

  for (row in rows){
    g <- gtable_add_grob(g,
                         grob = line.grob,
                         t = row, b = row, l = l, r = r)
  }

  return(g)
}


#' Title
#'
#' @param g
#' @param text
#' @param t
#' @param b
#' @param l
#' @param r
#' @param black
#' @param text.color
#' @param just
#' @param fontface
#' @param line
#' @param line.color
#' @param line.lwd
#' @param line.sep
#' @param bg_params
#' @param height
#'
#' @return
#' @export
#'
#' @examples
gtable_add_cspan <- function(
    g,
    text = "",
    t = 0,
    b = 0,
    l = 1,
    r = NULL,
    black = FALSE,
    text.color = "black",
    just = c("center","center"),
    fontface = "bold",
    line = TRUE,
    line.color = 'black',
    line.lwd = 1,
    line.sep = 0.1,
    bg_params = NULL,
    height = NULL){

  if (is.null(r)) r <- ncol(g)
  if (is.null(height)){
    height <- g$heights[1]
  }
  if (black){
    bg_params <- list(gp = gpar(fill='black',col='white'))
    text.color <- line.color <- 'white'
  }

  if (t==0){
    g <- gtable_add_rows(g, heights = unit(height, 'npc'), pos = 0)
    t <- b <- 1
  }
  bg <- !is.null(bg_params)
  gl <- gList()

  if (bg){
    b.grob <- do.call(rectGrob, bg_params)
    gl <- gList(b.grob)

  }
  if (line){
    line.grob <- linesGrob(
      x = unit(c(0+line.sep, 1-line.sep), "npc"),
      y = unit(0, "npc"),
      gp = gpar(col = line.color, lwd = line.lwd)
    )
    gl <- gList(gl, line.grob)
  }

  text.grob <- textGrob(
    text,
    just = just,
    gp = gpar(col=text.color,
              fontsize = getOption("fontsize"),
              fontfamily = getOption("default.fontfamily"),
              fontface = fontface)
  )

  gl <- gList(gl, text.grob)
  g <- gtable_add_grob(g,
                       grobs = grobTree(gl),
                       t=t, b=b, l=l, r=r)
  return(g)

}

#' Title
#'
#' @param g
#' @param cols
#' @param rows
#' @param union
#' @param name
#' @param bold
#' @param gp_params
#'
#' @return
#' @export
#'
#' @examples
grid.table.gp <- function(
    g,
    cols = NULL,
    rows = NULL,
    union = TRUE,
    name = 'core-fg',
    bold = F,
    gp_params = list()){

  j <- c()
  if(!is.null(cols)) j <- find_col(g, cols, name)
  if(!is.null(rows)) j <- c(j, find_row(g, rows, name))
  if(!union){
    j <- find_cell(g, rows, cols, name)
  }
  for (i in j){
    gpo <- g$grobs[[i]][["gp"]]
    if (bold) gp_params$font <- c(bold=2)
    g$grobs[[i]][["gp"]] <- modifyList(gpo, gp_params)
  }
 return(g)
}

#' Title
#'
#' @param DT
#' @param x
#' @param y
#' @param fontsize
#' @param booklines
#' @param hlines
#' @param hline
#' @param padding
#' @param widths
#' @param heights
#' @param width_pct
#' @param height_pct
#' @param black.heading
#' @param rows
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
grid.table.minimal <- function(DT,
                               x = 0.5,
                               y = 0.45,
                               fontsize = NULL,
                               booklines = TRUE,
                               hlines = NULL,
                               hline = gpar(col = "black", lwd = 1),
                               padding = unit(c(0, 0), "npc"),
                               widths = NULL,
                               heights = NULL,
                               width_pct = 0.75,
                               height_pct = 0.5,
                               black.heading = FALSE,
                               rows = NULL,
                               ...){

  if (is.null(fontsize)){
    fontsize <- getOption("fontsize", 12)
  }
  fontfamily <- getOption("default.fontfamily")
  vp <- viewport(x = x, y = y, height = 1, just = "center")

  if(black.heading){
    colhead <- list(bg_params = list(fill = "black", col="white"),fg_params = list(col = "white"))
    g <- tableGrob(DT,
                   theme=ttheme_minimal(base_size=fontsize,
                                        base_family=fontfamily,
                                        padding = padding,
                                        colhead = colhead,
                                        ...),
                   vp = vp,
                   rows=rows)
  }else{
    g <- tableGrob(DT,
                   theme=ttheme_minimal(base_size=fontsize,
                                        base_family=fontfamily,
                                        padding = padding,
                                        ...),
                   vp = vp,
                   rows = rows)
  }

  if (booklines){
    g <- gtable_add_hline(g, c(1, nrow(g), hlines), gp = hline, l = 1 + sum(!is.null(rows)), r = ncol(g))
  }

  if (is.null(widths)){
    w <- unit(rep((1/ncol(g)) * width_pct, ncol(g)), "npc")
    g$widths <- w
  }else{
    g$widths <- unit(widths, "npc")
  }

  if (is.null(heights)){
    h <- unit(rep((1/nrow(g)) * height_pct, nrow(g)), "npc")
    g$heights <- h
  }else{
    g$heights <- unit(heights, "npc")
  }

  return(g)
}
