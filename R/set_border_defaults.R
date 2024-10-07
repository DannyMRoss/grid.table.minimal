set_border_defaults <- function(
    show = FALSE,
    plot.width = 11, 
    plot.height = 8.5,
    plot.sep = 0.02,
    border.margin = 0.05, 
    caption.margin = 0.05,
    border.radius = 0.009,
    title.margin = 0.05, 
    title.radius = 0.1,
    title.width = 0.8,
    title.height = 0.1,
    title.sep = 0.011, 
    fontsize = 12,
    border.fontsize = 12,
    default.fontfamily = "LM Roman 10",
    border.fontfamily = "CMU Sans Serif",
    title.fontface = "bold",
    subtitle.fontface = "italic"
) {
  options(
    plot.width = plot.width, 
    plot.height = plot.height,
    plot.sep = plot.sep,
    caption.margin = caption.margin,
    border.margin = border.margin, 
    border.radius = border.radius,
    title.margin = title.margin, 
    title.radius = title.radius,
    title.width = title.width, 
    title.height = title.height,
    title.sep = title.sep, 
    fontsize = fontsize,
    border.fontsize = border.fontsize,
    border.fontfamily = border.fontfamily,
    default.fontfamily = default.fontfamily,
    title.fontface = title.fontface,
    subtitle.fontface = subtitle.fontface
  )
  
  if(show){
    print(list(
      plot.width = getOption("plot.width"), 
      plot.height = getOption("plot.height"),
      plot.sep = getOption("plot.sep"),
      caption.margin = getOption("caption.margin"),
      border.margin = getOption("border.margin"), 
      border.radius = getOption("border.radius"),
      title.margin = getOption("title.margin"), 
      title.radius = getOption("title.radius"),
      title.width = getOption("title.width"), 
      title.height = getOption("title.height"),
      title.sep = getOption("title.sep"), 
      fontsize = getOption("fontsize"),
      border.fontsize = getOption("border.fontsize"),
      border.fontfamily = getOption("border.fontfamily"),
      default.fontfamily = getOption("default.fontfamily"),
      title.fontface = getOption("title.fontface"),
      subtitle.fontface = getOption("subtitle.fontface")
    ))
  }
}

set_border_defaults()
