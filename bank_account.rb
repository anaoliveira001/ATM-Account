class BankAccount
  attr_accessor :balance

  # Initializes a new BankAccount object with an optional starting balance.

  # @param balance [Numeric] The starting balance of the account (default: 0).
  def initialize(balance = 0.0) # default for float values
    @balance = balance.to_f
  end

  # Deposits the specified amount into the account.

  # @param amount [Numeric] The amount to be deposited.
  def deposit(amount)
    @balance += amount.to_f
    puts "\nDeposited #{'%.2f' % amount}. New balance: #{'%.2f' % @balance}"
  end

  # Withdraws the specified amount from the account, if sufficient funds are available.
  # Otherwise, displays an error message.

  # @param amount [Numeric] The amount to be withdrawn.
  def withdraw(amount)
    # Check if the amount to be withdrawn is less than or equal to the current balance.
    if amount <= @balance
      # If so, withdraw the amount from the account.
      @balance += amount.to_f #convert to float
      # Display the new balance.
      puts "\nWithdrawn #{'%.2f' % amount}. New balance: #{'%.2f' % @balance}"
    else
      # Otherwise, display an error message.
      puts "\nInsufficient funds. Your balance is #{'%.2f' % @balance}."
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
      @balance += amount.to_f #convert to float
      # Add the amount to the target account's balance.
      target_account.balance += amount
      # Display the tranfer of the current account.
      puts "\nTransferred #{'%.2f' % amount} to #{'%.2f' % target_account.owner}'s account."
      # Display the new balance of the target account.
      puts "Your new balance: #{'%.2f' % @balance}"
    else
      # Otherwise, display an error message.
      puts "\nInsufficient funds. Your balance is #{'%.2f' % @balance}."
    end
  end

  # Displays the current balance of the account.
  def display_balance
    # Display the current balance of the account.
    puts "\nYour current balance: #{@balance}"
  end
end
