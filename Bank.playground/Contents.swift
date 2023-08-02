import Foundation

class VirtualBankSystem {
    var accountType = ""
    var isOpened = true
    
    func welcomeCustomer() {
        print("Welcome to your virtual bank system.")
    }
    
    func onboardCustomer(numberPadKey: Int) {
        print("The selected option is \(numberPadKey).")
        
        switch numberPadKey {
        case 1:
            accountType = "debit"
            print("You have opened a \(accountType) account.")

        case 2:
            accountType = "credit"
            print("You have opened a \(accountType) account.")

        default:
            print("Invalid input: \(numberPadKey)")
            break
        }
    }
    
    func moneyTransfer(transferType: String, transferAmount: Int, bankAccount: inout BankAccount){
        switch transferType {
        case "withdraw" :
            if accountType == "credit" {
                bankAccount.creditWithdraw(amount: transferAmount)
            } else if accountType == "debit"{
                bankAccount.debitWithdraw(amount: transferAmount)
            }
        case "deposit" :
            if accountType == "credit" {
                bankAccount.creditDeposit(amount: transferAmount)
            } else if accountType == "debit" {
                bankAccount.debitDeposit(amount: transferAmount)
            }
        default:
            break
        }
    }
    
    func checkBalance(bankAccount: BankAccount) {
        switch accountType {
        case "credit" :
            print(bankAccount.creditBalanceInfo)
        case "debit":
            print(bankAccount.debitBalanceInfo)
        default:
            break
        }
    }
    
    func manageBankAccount(bankAccount: inout BankAccount){
        repeat{
            print("What would you like to do?")
            print("1. Check bank account")
            print("2. Withdraw money")
            print("3. Deposit money")
            print("4. Close the system")
            
            let option = Int.random(in: 1...4)
            
            print("User selected option: \(option)")
            switch option {
                        case 1:
                            checkBalance(bankAccount: bankAccount)
                        case 2:
                            moneyTransfer(transferType: "withdraw", transferAmount: Int.random(in: 10...50), bankAccount: &bankAccount)
                        case 3:
                            moneyTransfer(transferType: "deposit", transferAmount: Int.random(in: 10...50), bankAccount: &bankAccount)
                        case 4:
                            isOpened = false // Close the system
                            print("The system is closed.")
                        default:
                            break
                        }
        } while isOpened
    }
}



struct BankAccount {
    var debitBalance = 0
    var creditBalance = 0
    let creditLimit = 100
    
    var debitBalanceInfo: String {
        return "Debit balance: $\(debitBalance)"
    }
    
    var availableCredit: Int {
        return creditLimit + creditBalance
    }
    
    var creditBalanceInfo: String {
        return "Available credit: $\(availableCredit)"
    }
    // debit deposit op
    mutating func debitDeposit(amount: Int) {
        debitBalance += amount
        print("Deposited $\(amount). \(debitBalanceInfo)")
    }
    //credit deposit op
    mutating func creditDeposit(amount: Int) {
        creditBalance += amount
        print("Credit $\(amount). \(creditBalanceInfo)")
        
        if creditBalance == 0 {
            print("Paid off credit balance.")
        } else if creditBalance > 0 {
                print("Overpaid credit balance.")
            }
    }
    //debit withdraw op
    mutating func debitWithdraw(amount: Int) {
        if amount > debitBalance {
            print("Insufficient fund to withdraw $\(amount). \(debitBalanceInfo)")
        } else {
            debitBalance -= amount
            print("Debit withdraw: $\(amount). \(debitBalanceInfo)")
        }
    }
    //credit withdraw op
    mutating func creditWithdraw(amount: Int) {
        if amount > availableCredit {
            print("Insufficient credit to withdraw $\(amount). \(creditBalanceInfo)")
        } else {
            creditBalance -= amount
            print("Credit withdraw: $\(amount). \(creditBalanceInfo)")
        }
    }
}

// Instantiate the VirtualBankSystem class and call the welcome customer method
let virtualBank = VirtualBankSystem()
virtualBank.welcomeCustomer()

// Step 5: Generating user input in the repeat while loop
var numberPadKey: Int = 0 // Initialize numberPadKey before the loop

repeat {
    // Use random(in:) method to generate a random number between 1 and 5
    numberPadKey = Int.random(in: 1...5)
    
    // Providing the user with account opening instructions
    virtualBank.onboardCustomer(numberPadKey: numberPadKey)
    
} while virtualBank.accountType == "" // Loop continues as long as accountType is empty

var bankAccount = BankAccount()

virtualBank.manageBankAccount(bankAccount: &bankAccount) // Run the virtual bank system interface with the bankAccount instance


