theme_borders <- function(
    axis.text = element_text(color="black"),
    axis.ticks = element_line(),
    axis.line = element_line(linewidth = .5, color = "black"),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    legend.position = c(0.9, 0.8),
    legend.text = element_text(face="plain", size = rel(4/6)),
    legend.title = element_text(face="plain", size = rel(5/6)),
    legend.margin = margin(t=0, b=0, l=0, r=0, unit='in'),
    legend.box.margin = margin(t=0, b=0, l=0, r=0, unit='in'), 
    strip.text = element_text(face="plain", size = rel(1)),
    plot.title = element_blank(),
    plot.subtitle = element_blank(),
    plot.caption = element_blank(),
    plot.caption.position = "panel",
    plot.title.position = "panel",
    ...){
  
  width <- getOption("plot.width", 8.5)
  height <- getOption("plot.height", 11)
  border.margin <- getOption("border.margin", 0.05)
  title.margin <- getOption("title.margin", 0.0525)
  title.height <- getOption("title.height", 0.1)
  plot.sep <- getOption("plot.sep", 0.01)
  caption.margin <- getOption("caption.margin", 0.5)
  plot.font.family <- getOption("label.fontfamily", "LM Roman 10")
  plot.font.size <- getOption("fontsize", 12)
  
  plot.t.m <- height * (border.margin + title.margin + plot.sep + title.height)
  plot.b.m <- width * (border.margin + plot.sep + caption.margin)
  plot.lr.m <- width * (border.margin + plot.sep)
  
  theme_minimal() + 
    theme(
      text = element_text(family = plot.font.family, size = plot.font.size),
      axis.text = axis.text,
      axis.ticks = axis.ticks,
      axis.line = axis.line,
      panel.grid.major = panel.grid.major, 
      panel.grid.minor = panel.grid.minor,
      legend.text = legend.text,
      legend.position = legend.position,
      legend.margin = legend.margin,
      legend.box.margin = legend.box.margin, 
      strip.text = strip.text,
      plot.margin = margin(t=plot.t.m, b=plot.b.m, l=plot.lr.m, r=plot.lr.m, unit='in'),
      plot.title = plot.title,
      plot.subtitle = plot.subtitle,
      plot.caption = plot.caption,
      plot.caption.position = plot.caption.position,
      plot.title.position = plot.title.position,
      axis.title = element_text(margin = margin(t=0, b=0, l=0, r=0, unit='in')),
      ...
    )
}


