admin_user = User.create(name: "admin",email: "admin@ticketee.com", password: "password", password_confirmation: "password", admin: true)

Project.create(name: "Ticketee Beta")
Project.create(name: "tester 2")
Project.create(name: "tester 3")