u = User.create!(email: "user@gmail.com", password: "123456",name: "user", gender: 0, cnic: "3520212345679", address: "40, block k, city, country")
u2 = User.create!(email: "use1r@gmail.com", password: "123456",name: "userr", gender: 0, cnic: "3520212345678", address: "40, block k, city, country")

u.confirm
u2.confirm

u.add_role :user
u2.add_role :user

PurposeOfPayment.create!(name: "Fuel Reimbursment")

