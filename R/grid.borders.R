grid.watermark <- function(label = "",
                           draw = TRUE,
                           x = 0.5,
                           y = 0.5,
                           rot = 45,
                           fontsize = 12,
                           cex = 8,
                           alpha = 0.1,
                           color = "grey",
                           fontface = "bold"
){
  
  fontfamily <- getOption("default.fontfamily")
  fontsize <- getOption("fontsize", 12)
  watermarktext <- textGrob(label = label,
                            x = x, 
                            y = y, 
                            just = c("center","center"),
                            rot = rot,
                            gp = gpar(color = color, 
                                      cex = cex,
                                      fontsize = fontsize,
                                      fontfamily = fontfamily,
                                      alpha=alpha))
  if(draw){
    grid.draw(watermarktext)
  }else{
    return(watermarktext)
  }
}

grid.caption <- function(label = "Notes & Sources:",
                         caption = c(),
                         y = NULL,
                         nudge_x = 0,
                         nudge_y = NULL,
                         sep = 0.02,
                         cex = 5/6){
  
  border.margin <- getOption("border.margin", 0.05)
  fontsize <- getOption("fontsize", 12)
  fontfamily <- getOption("default.fontfamily")
  if (is.null(nudge_y)){
    y <- (border.margin + sep * (length(caption) + 0.5))
  }else{
    y <- (nudge_y + sep * (length(caption) + 0.5))
  }
  
  if (!is.null(label)){
    grid.draw(textGrob(label = bquote(bold(underline(.(label)))), 
                       x = 0.5 + nudge_x,
                       y = y, 
                       just = c("center","bottom"), 
                       gp = gpar(fontsize = fontsize,
                                 cex = cex,
                                 fontfamily = fontfamily)))
  }
  
  for (i in seq_along(caption)) {
    grid.draw(textGrob(label = caption[i], 
                       x = 0.5 + nudge_x,
                       y = (y - i * sep), 
                       just = c("center","bottom"), 
                       gp = gpar(fontsize = fontsize,
                                 cex = cex,
                                 fontfamily = fontfamily)))
  }
}

grid.slip <- function(label = "",
                      draw = TRUE,
                      layout = "portrait",
                      fontsize = 12,
                      cex = 2,
                      fontfamily = "LM Roman 10",
                      fontface = "bold"
){
  sliptext <- textGrob(label = label,
                       rot = if_else(layout=="landscape",90,0),
                       x = 0.5, 
                       y = 0.5, 
                       just = c("center","center"),
                       gp = gpar(fontface = fontface,
                                 cex = cex,
                                 fontsize = fontsize,
                                 fontfamily = fontfamily))
  if(draw){
    grid.draw(sliptext)
    grid.newpage()
  }else{
    return(sliptext)
  }
}


grid.borders <- function(
    top = c(l = "", c = "", r = ""),
    bottom = c(l = "", c = "", r = ""),
    left = c(b = "", c = "", t = ""),
    right = c(b = "", c = "", t = ""),
    title = NULL,
    subtitle = NULL,
    caption = NULL,
    grid.caption.params = list(),
    watermark = NULL,
    grid.watermark.params = list(),
    clear = FALSE
){
  
  border.margin <- getOption("border.margin", 0.05)
  border.radius <- getOption("border.radius", 0.009)
  title.margin <- getOption("title.margin", 0.05)
  title.radius <- getOption("title.radius", 0.1)
  title.width <- getOption("title.width", 0.8)
  title.height <- getOption("title.height", 0.1)
  title.sep <- getOption("title.sep", 0.01)
  title.fontsize <- getOption("fontsize", 12)
  fontsize <- getOption("border.fontsize", 12)
  border.fontfamily <- getOption("border.fontfamily")
  default.fontfamily <- getOption("default.fontfamily")
  
  if (clear && !dev.interactive() && !is.null(dev.list())) dev.off()
  box <- 1 - 2 * border.margin
  
  titlebox <- roundrectGrob(x = 0.5, 
                            y = 1 - border.margin - title.margin, 
                            width = title.width, 
                            height = title.height, 
                            r = unit(title.radius, "snpc"),
                            just=c("center","top"),
                            gp = gpar(fill = NA))
  borderbox <- roundrectGrob(x = 0.5, 
                             y = 0.5, 
                             width = box, 
                             height = box, 
                             r = unit(border.radius, "snpc"),
                             just = c("center", "center"),
                             gp = gpar(fill=NA, lwd=1))
  
  bgp <- gpar(color="black", fontsize = fontsize, fontfamily = border.fontfamily)
  
  tb.x <- c(border.margin, .5, box + border.margin)
  t.y <- 1 - (border.margin / 2)
  b.y <- border.margin / 2
  tb.x.just <- c("left","center","right")
  
  lx <- (border.margin / 2)
  rx <- 1 - (border.margin / 2)
  lr.y <- c(border.margin, .5, box + border.margin)
  l.x.just <- c("left","center","right")
  r.x.just <- rev(l.x.just)
  lr.y.just <- "top"
  
  grid.draw(titlebox)
  grid.draw(borderbox)
  for (i in seq_along(top)){
    grid.draw(textGrob(label = top[[i]],
                       x = tb.x[i], 
                       y = t.y, 
                       just = c(tb.x.just[i],"center"),
                       gp = bgp))
  }
  for (i in seq_along(bottom)){
    grid.draw(textGrob(label = bottom[[i]],
                       x = tb.x[i], 
                       y = b.y, 
                       just = c(tb.x.just[i],"center"),
                       gp = bgp))
  }
  for (i in seq_along(left)){
    grid.draw(textGrob(label = left[[i]],
                       x = lx, 
                       y = lr.y[i], 
                       rot = 90,
                       just = c(l.x.just[i],"center"),
                       gp = bgp))
  }
  for (i in seq_along(right)){
    grid.draw(textGrob(label = right[[i]],
                       x = rx, 
                       y = lr.y[i], 
                       rot = -90,
                       just = c(r.x.just[i],"center"),
                       gp = bgp))
  }
  
  title.y <- (1 - border.margin - title.margin - (title.height / 2))
  if (!is.null(subtitle)) title.y <- title.y + title.sep
  subtitle.y <- (1 - border.margin - title.margin - (title.height / 2)) - 2*title.sep
  
  if (!is.null(title)){
    grid.text(title,
              x = .5,
              y = title.y,
              gp = gpar(fontfamily = default.fontfamily, 
                        fontsize=title.fontsize, 
                        cex=7/6, 
                        fontface=getOption("title.fontface", "bold")),
              just = c("center","center"))
  }
  if (!is.null(subtitle)){
    grid.text(subtitle,
              x=.5,
              y=subtitle.y,
              gp = gpar(fontfamily = default.fontfamily, 
                        fontsize=title.fontsize, 
                        cex=1, 
                        fontface=getOption("subtitle.fontface", "italic")),
              just = c("center","center"))
  }
  if (!is.null(caption)){
    grid.caption.params$label <- names(caption)
    grid.caption.params$caption <- caption[[1]]
    do.call(grid.caption, grid.caption.params)
  }
  if (!is.null(watermark)){
    grid.watermark.params$label <- watermark
    do.call(grid.watermark, grid.watermark.params)
  }
}
