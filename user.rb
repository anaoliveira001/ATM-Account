require 'bcrypt'
require_relative 'bank_account'

# The User class represents a user of the ATM system.
class User
  # The 'attr_accessor' method is used to create getter and setter methods for the 'username' and 'bank_account' instance variables.
  attr_accessor :username, :bank_account

  # Initializes a new User object with the given username and password.
  # It also creates a new BankAccount object for the user.
  # @param username [String] the username for the user
  # @param password [String] the password for the user
  # # @return [User] the newly created User object


  def initialize(username, password)
    # The 'username' and 'password_hash' instance variables are initialized with the given values.
    @username = username
    @password_hash = BCrypt::Password.create(password)
    # A new BankAccount object is created and assigned to the 'bank_account' instance variable.
    @bank_account = BankAccount.new
  end

  # Checks if the provided password matches the user's password.
  # @param password [String] the password to be checked
  # @return [Boolean] true if the password is valid, false otherwise

  def valid_password?(password)
    # The '==' operator is used to compare the password with the password hash.
    # # The 'BCrypt::Password.new' method is used to create a new BCrypt::Password object from the password hash.
    BCrypt::Password.new(@password_hash) == password
  end

  # Resets the user's password.
  def change_password(current_password, new_password) # The 'change_password' method is used to reset the user's password.
    if valid_password?(current_password) # The 'valid_password?' method is used to check if the password is valid.
      @password_hash = BCrypt::Password.create(new_password) # The 'BCrypt::Password.create' method is used to create a new password hash.
      puts "\nPassword changed successfully!"
    else
      puts "\nIncorrect current password. Please try again."
      false  # Return false if password change fails
    end
  end
end
