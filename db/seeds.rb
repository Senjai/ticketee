User.create!(name: "admin",email: "admin@ticketee.com", password: "password", password_confirmation: "password", admin: true)

Project.create(name: "Ticketee Beta")

State.create(name: "New",
             background: "#85FF00",
             color: "white",
             default: true)

State.create(name: "Open",
             background: "#00CFFD",
             color: "white")

State.create(name: "Closed",
             background: "black",
             color: "white")