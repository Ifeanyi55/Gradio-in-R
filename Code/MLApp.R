library(reticulate)

# import gradio
gr <- import("gradio")

df <- mtcars

# train regression model
model <- lm(mpg ~.,data = df)

# save model
saveRDS(model,file = "model")

# build prediction function
md_predict <- \(cyl,disp,hp,drat,wt,qsec,vs,am,gear,carb){

  new_data <- data.frame(
    cyl = c(cyl),
    disp = c(disp),
    hp = c(hp),
    drat = c(drat),
    wt = c(wt),
    qsec = c(qsec),
    vs = c(vs),
    am = c(am),
    gear = c(gear),
    carb = c(carb)
  )

  # load model
  md <- readRDS("model")

  resp <- floor(predict(md,new_data))

  return(resp)

}

# build gradio app with block
app <- gr$Blocks(
  #theme = gr$themes$Soft(),
  analytics_enabled = TRUE,
  fill_height = TRUE
)

with(app,{
  gr$Markdown("<center><h2><strong>Cars Miles Per Gallon Predictor</strong></h2></center>")
  number1 <- gr$Slider(interactive = TRUE, label = "Cyl", minimum = 0, maximum = 8, step = 1)
  number2 <- gr$Slider(interactive = TRUE, label = "Disp", minimum = 0, maximum = 480, step = 1)
  number3 <- gr$Slider(interactive = TRUE, label = "Hp", minimum = 0, maximum = 350, step = 1)
  number4 <- gr$Slider(interactive = TRUE, label = "Drat", minimum = 0, maximum = 5, step = 1)
  number5 <- gr$Slider(interactive = TRUE, label = "Wt", minimum = 0, maximum = 6, step = 1)
  number6 <- gr$Slider(interactive = TRUE, label = "Qsec", minimum = 0, maximum = 25, step = 1)
  number7 <- gr$Slider(interactive = TRUE, label = "Vs", minimum = 0, maximum = 1, step = 1)
  number8 <- gr$Slider(interactive = TRUE, label = "Am", minimum = 0, maximum = 1, step = 1)
  number9 <- gr$Slider(interactive = TRUE, label = "Gear", minimum = 0, maximum = 5, step = 1)
  number10 <- gr$Slider(interactive = TRUE, label = "Carb", minimum = 0, maximum = 8, step = 1)

  gr$Markdown("<center><h2><strong>Miles Per Gallon Prediction</strong></h2></center>")

  gr$Row(number1,number2,number3,number4,number5,number6,number7,
         number8,number9,number10)
  
  btn <- gr$Button("Run Prediction")

  output <- gr$Number(label = "Predicted Miles Per Gallon")
  gr$Column(output)

  btn$click(
    fn = md_predict,
    inputs = list(number1,number2,number3,number4,number5,number6,number7,
             number8,number9,number10),
    outputs = output
  )
})

# run app
app$launch(server_name = "localhost", server_port = as.integer(3000))
