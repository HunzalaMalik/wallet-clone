u = User.create!(email: "user@gmail.com", password: "123456",name: "user", gender: 0, cnic: "3520212345679", contact_no: "08002122345", address: "40, block k, city, country")
u2 = User.create!(email: "user1@gmail.com", password: "123456",name: "userr", gender: 1, cnic: "3520212345678", contact_no: "08002122342" , address: "40, block k, city, country")
u3 = User.create!(email: "admin@gmail.com", password: "123456",name: "Admin", gender: 2, cnic: "3520212345672", contact_no: "08002122341" , address: "20, block p, city, country")

u.confirm
u2.confirm
u3.confirm

u3.remove_role :user
u3.add_role :admin

PurposeOfPayment.create!(purpose: "Fuel Reimbursment")
PurposeOfPayment.create!(purpose: "Recharge")
PurposeOfPayment.create!(purpose: "Charity")
PurposeOfPayment.create!(purpose: "Donation")

