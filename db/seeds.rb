User.create!(name: "admin",email: "admin@ticketee.com", password: "password", password_confirmation: "password", admin: true)

Project.create(name: "Ticketee Beta")