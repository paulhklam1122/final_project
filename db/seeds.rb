15.times do
  user = User.create  first_name:       Faker::Name.first_name,
                      last_name:        Faker::Name.last_name,
                      email:            Faker::Internet.email,
                      password:         "123"
end

users = User.all
users.each do |user|
  Profile.create(user_id: user.id, income: rand(10000..100000))
  BankAccount.create(bank_name: Faker::Company.name, account_type: "Chequeing", account_balance: rand(1000..6000), user_id: user.id)
  BankAccount.create(bank_name: Faker::Company.name, account_type: "Savings", account_balance: rand(10000..100000), user_id: user.id)
  BankAccount.create(bank_name: Faker::Company.name, account_type: "TFSA", account_balance: rand(0..46500), user_id: user.id)
  CreditCard.create(card_name:"TD MasterCard", monthly_balance: rand(1000..3000), user_id: user.id)
  CreditCard.create(card_name:"RBC Visa", monthly_balance: rand(1000..3000), user_id: user.id)
  Expense.create(expense_name: "Groceries", amount: rand(100..300), user_id: user.id)
  Expense.create(expense_name: "Tennis Lessons", amount: rand(50..100), user_id: user.id)
  Goal.create(goal_name: "Buy a Car", amount: rand(10000..50000), user_id: user.id)
  Goal.create(goal_name: "Save for home purchase downpayment", amount: rand(70000..120000), user_id: user.id)
  Goal.create(goal_name: "Go on Vacation", amount: rand(1000..3000), user_id: user.id)
  LoanAccount.create(loan_name: "Mortgage", balance: rand(200000..500000), monthly_payment: rand(800..10000), user_id: user.id)
  Property.create(name: "Principal Residence", value: rand(300000..1000000), user_id: user.id)
end

user = User.create first_name: "Tam", last_name: "Kbeili",email: "tkbeili@codecore.ca", password: "t"
Profile.create(income: 150000, user_id: user.id)
BankAccount.create(bank_name: "Awesome Bank", account_type: "Chequeing", account_balance: 7000, user_id: user.id)
BankAccount.create(bank_name: "Awesome Bank", account_type: "Savings", account_balance: 120000, user_id: user.id)
CreditCard.create(card_name:"RBC Visa", monthly_balance: 2300, user_id: user.id)
Expense.create(expense_name: "Groceries", amount: rand(100..300), user_id: user.id)
Expense.create(expense_name: "SUPER Awesome Pokemon GO Egg Incubators", amount: 150, user_id: user.id)
Goal.create(goal_name: "Buy a West Vancouver Mansion", amount: 6500000, user_id: user.id)
Goal.create(goal_name: "Send Girls to Disneyland", amount: 2000, user_id: user.id)
LoanAccount.create(loan_name: "Mortgage", balance: 320000, monthly_payment: 1200, user_id: user.id)
Property.create(name: "Principal Residence", value: 600000, user_id: user.id)

user = User.create first_name: "Jacob", last_name: "Tran",email: "jtran@codecore.ca", password: "j"
Profile.create(user_id: user.id, income: 90000)
BankAccount.create(bank_name: "TD", account_type: "Chequeing", account_balance: 6200, user_id: user.id)
BankAccount.create(bank_name: "RBC", account_type: "Savings", account_balance: 115000, user_id: user.id)
CreditCard.create(card_name:"RBC Visa", monthly_balance: 2100, user_id: user.id)
Expense.create(expense_name: "Groceries", amount: rand(100..300), user_id: user.id)
Expense.create(expense_name: "EA Game Titles", amount: 250, user_id: user.id)
Goal.create(goal_name: "Save for a Justin Bieber concert", amount: 800, user_id: user.id)
Goal.create(goal_name: "Send Girls to Disneyland", amount: 2000, user_id: user.id)
LoanAccount.create(loan_name: "Mortgage", balance: 600000, monthly_payment: 1800, user_id: user.id)
Property.create(name: "Principal Residence", value: 1200000, user_id: user.id)
