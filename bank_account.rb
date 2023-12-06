class BankAccount
  attr_accessor :balance

  # Initializes a new BankAccount object with an optional starting balance.

  # @param balance [Numeric] The starting balance of the account (default: 0).
  def initialize(balance = 0)
    @balance = balance
  end

  # Deposits the specified amount into the account.

  # @param amount [Numeric] The amount to be deposited.
  def deposit(amount)
    @balance += amount
    puts "\nDeposited #{amount}. New balance: #{@balance}"
  end

  # Withdraws the specified amount from the account, if sufficient funds are available.
  # Otherwise, displays an error message.

  # @param amount [Numeric] The amount to be withdrawn.
  def withdraw(amount)
    # Check if the amount to be withdrawn is less than or equal to the current balance.
    if amount <= @balance
      # If so, withdraw the amount from the account.
      @balance -= amount
      # Display the new balance.
      puts "\nWithdrawn #{amount}. New balance: #{@balance}"
    else
      # Otherwise, display an error message.
      puts "\nInsufficient funds. Your balance is #{@balance}."
    end
  end

  # Transfers the specified amount from the current account to the target account,
  # if sufficient funds are available. Otherwise, displays an error message.

  # @param amount [Numeric] The amount to be transferred.
  # @param target_account [BankAccount] The target account to transfer the amount to.
  def transfer(amount, target_account)
    # Check if the amount to be transferred is less than or equal to the current balance.
    if amount <= @balance
      # If so, transfer the amount from the current account to the target account.
      @balance -= amount
      # Add the amount to the target account's balance.
      target_account.balance += amount
      # Display the tranfer of the current account.
      puts "\nTransferred #{amount} to #{target_account.owner}'s account."
      # Display the new balance of the target account.
      puts "Your new balance: #{@balance}"
    else
      # Otherwise, display an error message.
      puts "\nInsufficient funds. Your balance is #{@balance}."
    end
  end

  # Displays the current balance of the account.
  def display_balance
    # Display the current balance of the account.
    puts "\nYour current balance: #{@balance}"
  end
end
