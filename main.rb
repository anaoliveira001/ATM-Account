# This program simulates an ATM account system. It allows users to create an account, login, perform various banking operations such as deposit, withdraw, transfer, and check balance, and reset their password if needed.

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
  choice = gets.chomp.to_i
# The 'case' statement is used to execute different code blocks based on the value of the 'choice' variable.
  case choice
  # The 'when' keyword is used to specify the value of the 'choice' variable for which the code block should be executed.
  when 1
    puts "Enter username:"
    username = gets.chomp

    puts "Enter password:"
    password = STDIN.noecho(&:gets).chomp
    # The '<<' operator is used to append the newly created user object to the 'users' array.
    users << User.new(username, password)
    puts "\nUser created."

  when 2
    puts "Enter username:"
    login_username = gets.chomp
    # The 'STDIN.noecho(&:gets)' method is used to hide the user's input when entering the password.
    puts "Enter password:"
    login_password = STDIN.noecho(&:gets).chomp

    # Find the user with the matching username in the 'users' array.
    user = users.find { |user| user.username == login_username }

    # Check if the user exists and the password is valid.
    if user && user.valid_password?(login_password)
      puts "\nLogin successful!"

      # The 'while' loop is used to display the ATM menu and prompt the user to select an option.
      while true
        puts "\n1. Deposit"
        puts "2. Withdraw"
        puts "3. Transfer"
        puts "4. Check Balance"
        puts "5. Logout"
        # user_choice: Stores the user's input for the selected option in the ATM system. It is obtained from the user through the gets.chomp method and converted to an integer using the to_i method.
        user_choice = gets.chomp.to_i

        case user_choice
        when 1
          puts "Enter amount to deposit:"
          amount = gets.chomp.to_i
          user.bank_account.deposit(amount)

        when 2
          puts "Enter amount to withdraw:"
          # The 'gets.chomp' method is used to get the user's input for the amount to be withdrawn.
          amount = gets.chomp.to_i
          user.bank_account.withdraw(amount)

        when 3
          puts "Enter amount to transfer:"
          # The 'gets.chomp' method is used to get the user's input for the amount to be transferred.
          amount = gets.chomp.to_i
          puts "Enter recipient's username:"
          recipient_username = gets.chomp
          # Find the recipient user object based on the recipient username
          recipient = users.find { |u| u.username == recipient_username }
          # Check
          if recipient
            # Transfer the specified amount from the current user's account to the recipient's account.
            user.bank_account.transfer(amount, recipient.bank_account)
          else
            puts "Recipient not found."
          end

        when 4
          # Display the current balance of the user's account.
          user.bank_account.display_balance

        when 5
          # Break out of the 'while' loop and go back to the main menu.
          puts "\nLogged out."
          break

        else
          # Display an error message if the user enters an invalid option.
          puts "Invalid choice."
        end
      end
    else
      # Display an error message if the user enters an invalid username or password.
      puts "\nInvalid username or password."
    end

  when 3
    # forgot_password: Stores the user's input for the selected option in the ATM system. It is obtained from the user through the gets.chomp method and converted to an integer using the to_i method.
    puts "Forgot Password?"
    puts "Enter username or identifying information:"
    # The 'gets.chomp' method is used to get the user's input for the identifier.
    identifier = gets.chomp

    # Find the user with the specified identifier in the users array.
    # Parameters:
    # - users: An array of user objects.
    # - identifier: The identifier of the user to find.
    # Returns:
    # The user object with the specified identifier, or nil if no user is found.
    user = users.find { |u| u.username == identifier }

    if user
      puts "Enter new password:"
      #new_password: Stores the user's input for the new password. It is obtained from the user through the gets.chomp method and converted to an integer using the to_i method.
      new_password = STDIN.noecho(&:gets).chomp
      user.reset_password(new_password)
    else
      # Display an error message if the user is not found.
      puts "User not found."
    end
  when 4
    # Break out of the main loop and exit the program.
    break
  else
    # Display an error message if the user enters an invalid option.
    puts "Invalid choice. Please enter 1, 2, or 3."
  end

end
