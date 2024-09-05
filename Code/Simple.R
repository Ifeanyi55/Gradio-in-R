library(reticulate)

# py_install("gradio",pip = TRUE)

# import gradio
gr <- import("gradio")

# create function
record <- \(name,gender,occupation,age){

  gender = tolower(gender)

  if(gender == "male"){
    return(paste(name, "is", glue::glue(age,","), "and he is a", occupation))
  } else if(gender == "female"){
    return(paste(name, "is", glue::glue(age,","), "and she is a", occupation))
  }

}

# build gradio interface
gr_app <- gr$Interface(record,
  inputs = c(gr$Text(label = "Name"),gr$Radio(label = "Gender", choices = c("Male","Female"),value = c("Male","Female")),gr$Text(label = "Occupation"),gr$Number(label = "Age")),
  outputs = gr$Text(label = "Report"),
  title = "Record",
  theme = gr$themes$Soft()
)

# launch application
gr_app$launch(server_name = "localhost",server_port = as.integer(4000))