library(glue)

# import gradio
gr <- import("gradio")

# Define functions for each tab
greet <- function(name) {
  paste0("Hello, ", name, "!")
}

reverse_text <- function(text) {
  paste0(strsplit(text, "")[[1]][length(strsplit(text, "")[[1]]):1], collapse = "")
}

# create the gradio interface with tabs
ui <- gr$Interface(
  fn = greet,
  inputs = gr$Textbox(lines = 1, placeholder = "Enter your name"),
  outputs = "text",
  title = "Greeting App"
)

ui2 <- gr$Interface(
  fn = reverse_text,
  inputs = gr$Textbox(lines = 1, placeholder = "Enter text to reverse"),
  outputs = "text",
  title = "Text Reverser"
)

tabbed_app <- gr$TabbedInterface(
  c(ui, ui2),
  tab_names = c("Greeting", "Reverser")
)

# launch the app
tabbed_app$launch(server_name = "localhost", server_port = as.integer(4000))
