# This program simulates an ATM account system. It allows users to create an account, login, perform various banking operations such as deposit, withdraw, transfer, and check balance, and reset their password if needed.
#Version 1.2

require 'io/console'
require_relative 'user'

# users: An array of user objects.
users = []

# The main loop of the program. It displays the main menu and prompts the user to select an option.
while true
  puts "\n1. Create user"
  puts "2. Login"
  puts "3. Exit"
  # The variable 'choice' stores the user's input after converting it to an integer using 'to_i'.
  choice = gets.chomp.to_f

# The 'case' statement is used to execute different code blocks based on the value of the 'choice' variable.
  case choice
  when 1
    puts "Enter username:"
    username = gets.chomp

    puts "Enter password:"
    password = STDIN.noecho(&:gets).chomp

    users << User.new(username, password)
    puts "\nUser created."

  when 2
    puts "Enter username:"
    login_username = gets.chomp

    puts "Enter password:"
    login_password = STDIN.noecho(&:gets).chomp

    user = users.find { |user| user.username == login_username }

    if user && user.valid_password?(login_password)
      puts "\nLogin successful!"
      # The 'while' loop is used to display the user menu and prompt the user to select an option.
      while true
        puts "\n1. Deposit"
        puts "2. Withdraw"
        puts "3. Transfer"
        puts "4. Check Balance"
        puts "5. Logout"

        user_choice = gets.chomp.to_f
        # The 'case' statement is used to execute different code blocks based on the value of the 'user_choice' variable.
        case user_choice
        when 1
          puts "Enter amount to deposit:"
          amount = gets.chomp.to_f
          user.bank_account.deposit(amount)
         # The when 2 
        when 2
          puts "Enter amount to withdraw:"
          amount = gets.chomp.to_f
          user.bank_account.withdraw(amount)
          #
        when 3
          puts "Enter amount to transfer:"
          amount = gets.chomp.to_f
          puts "Enter recipient's username:"
          recipient_username = gets.chomp
          recipient = users.find { |u| u.username == recipient_username }
          if recipient
            user.bank_account.transfer(amount, recipient.bank_account)
          else
            puts "Recipient not found."
          end

        when 4
          user.bank_account.display_balance

        when 5
          puts "\nLogged out."
          break

        else
          puts "Invalid choice."
        end
      end
    else
      puts "\nInvalid username or password."
    end

  when 3
    puts "Change Password"
    puts "Enter username:"
    username = gets.chomp

    user = users.find { |u| u.username == username }

    if user
      loop do
        puts "Enter current password:"
        current_password = STDIN.noecho(&:gets).chomp

        if user.change_password(current_password, new_password)
          break  # Break the loop if password change is successful
        end
      end
    else
      puts "User not found."
    end

  when 4
    break

  else
    puts "Invalid choice. Please enter 1, 2, or 3."
  end

end
