// make the compiled output idempotent
#set document(date: none)

#for _ in range(4) [
  = Hello World
  #lorem(125)
]
