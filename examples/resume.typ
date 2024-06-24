#set document(date: none)
#set page(
  header: [
    #text(2em)[*Firstname Lastname*] \
    example\@example.com |
    #link("https://www.linkedin.com/in/")[linkedin.com/in/] |
    #link("https://www.github.com/")[github.com/] |
    City, State
  ],
)

#let titleline(title) = {
  v(1em)
  text[== #title]
  v(-2pt); line(length: 100%); v(-2pt)
}

#let entry(org, date, role, location) = {
  text[
    *#org* #h(1fr) #date \
    #emph([#role]) #h(1fr) #emph([#location])
  ]
}

#lorem(40)


#titleline[Skills]
#for c in range(2) [
  *#lorem(2)*: #lorem(8) \
  *#lorem(3)*: #lorem(10) \
]


#titleline[Experience]
#for c in range(4) [
  #entry("Org Name", "Jan 1970 - Jan 2038", "Title Name", "City, State")
  - #lorem(10)
  - #lorem(13)
  - #lorem(11)
]


#titleline[Education]
#for c in range(2) [
  #entry("School Name", "Jan 1970 - Jan 2038", "Description", "City, State")
  - #lorem(12)
  - #lorem(13)
]
