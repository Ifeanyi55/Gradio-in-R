library(reticulate)

# import gradio
gr <- import("gradio")

process_text <- function(text, uppercase = FALSE, reverse = FALSE) {
  result <- text
  if (uppercase) {
    result <- toupper(result)
  }
  if (reverse) {
    result <- paste(rev(strsplit(result, "")[[1]]), collapse = "")
  }
  return(result)
}

# build the gradio interface with an accordion
app <- gr$Blocks()

with(app, {
  gr$Markdown("<center><h2><strong>Accordion Gradio App</strong></h2></center>")

  text_input <- gr$Text(label = "Enter Text")
  output_text <- gr$Text(label = "Processed Text")

  with(gr$Accordion(label = "Processing Options", open = FALSE), {
    uppercase_checkbox <- gr$Checkbox(label = "Uppercase")
    reverse_checkbox <- gr$Checkbox(label = "Reverse")
  })

  process_button <- gr$Button("Process")

  process_button$click(
    fn = process_text,
    inputs = list(text_input, uppercase_checkbox, reverse_checkbox),
    outputs = output_text
  )
})

# launch the app
app$launch(server_name = "0.0.0.0", server_port = as.integer(4000))
