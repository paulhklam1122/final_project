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
