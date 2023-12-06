# This program simulates an ATM account system. It allows users to create an account, login, perform various banking operations such as deposit, withdraw, transfer, and check balance, and reset their password if needed.
#Version 1.2

require 'io/console' # The 'io/console' library is used to hide the password while the user is typing it.
require_relative 'user' # The 'user' file is imported to use the User class.

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
    # The 'noecho' method is used to hide the password while the user is typing it.
    password = STDIN.noecho(&:gets).chomp

    #new user object
    users << User.new(username, password) # The '<<' operator is used to append the new user object to the 'users' array.
    puts "\nUser created."

  when 2
    puts "Enter username:"
    login_username = gets.chomp
    # The 'noecho' method is used to hide the password while the user is typing it.
    puts "Enter password:"
    login_password = STDIN.noecho(&:gets).chomp

    user = users.find { |user| user.username == login_username }
    # The 'valid_password?' method is used to check if the password is valid.
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
          # The 'deposit' method is used to deposit the specified amount into the account.
          user.bank_account.deposit(amount)
         # The when 2

        when 2
          # The 'withdraw' method is used to withdraw the specified amount from the account.
          puts "Enter amount to withdraw:"
          amount = gets.chomp.to_f
          # The 'withdraw' method is used to withdraw the specified amount from the account.
          user.bank_account.withdraw(amount)

        when 3
          # The 'find' method is used to find the user with the given username.
          puts "Enter amount to transfer:"
          amount = gets.chomp.to_f
          puts "Enter recipient's username:"
          recipient_username = gets.chomp
          # The 'find' method is used to find the user with the given username.
          recipient = users.find { |u| u.username == recipient_username }
          if recipient
            # The 'transfer' method is used to transfer the specified amount from the current account to the recipient's account.
            user.bank_account.transfer(amount, recipient.bank_account)
          else
            puts "Recipient not found."
          end

        when 4
          # The 'display_balance' method is used to display the current balance of the account.
          user.bank_account.display_balance

        when 5
          # Break the user menu loop if the user selects 'Logout'.
          puts "\nLogged out."
          break
        else
          # Display an error message if the user enters an invalid choice.
          puts "Invalid choice."
        end
      end
    else
      # Display an error message if the user is not found or the password is invalid.
      puts "\nInvalid username or password."
    end
  when 3
    # Break the main loop if the user selects 'Exit'.
    puts "Change Password"
    puts "Enter username:"
    username = gets.chomp
    # The 'find' method is used to find the user with the given username.
    user = users.find { |u| u.username == username }

    if user
      loop do
        puts "Enter current password:"
        current_password = STDIN.noecho(&:gets).chomp
        # The 'valid_password?' method is used to check if the current password is valid.
        if user.change_password(current_password, new_password)
          break  # Break the loop if password change is successful
        end
      end
    else
      # Display an error message if the user is not found.
      puts "User not found."
    end

  when 4
    # Break the main loop if the user selects 'Exit'.
    break
  else
    # Display an error message if the user enters an invalid choice.
    puts "Invalid choice. Please enter 1, 2, or 3."
  end
end
