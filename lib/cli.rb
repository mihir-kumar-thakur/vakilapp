class CLI
  FUNCTIONS = {
    "1" => { method: :add_sr_advocate,
      inputs: { code: "Add an advocate: " }
    },

    "2" => {
      method: :add_jr_advocate,
      inputs: {
        sr_code: "Senior Advocate ID: ",
        jr_code: "Junior ID: "
      }
    },

    "3" => {
      method: :add_practicing_state,
      inputs: {
        adv_code: "Advocate ID: ",
        state_name: "Practicing State: "
      }
    },

    "4" => {
      method: :add_case,
      inputs: {
        adv_code: "Advocate ID: ",
        case_code: "Case ID: ",
        state_name: "Practicing State: "
      }
    },

    "5" => {
      method: :reject_case,
      inputs: {
        adv_code: "Advocate ID: ",
        case_code: "Case ID: ",
        state_name: "Practicing State: "
      }
    },
    "6" => {
      method: :all_advocates,
      inputs: {}
    },
    "7" => {
      method: :case_under_state,
      inputs: {
        state: "State Name: "
      }
    }
  }

  def self.run
    puts "Welcome to advocate management system".magenta

    while true
      menu

      choice = choice_with_message("Input: ")

      if choice == "8"
        puts "Thank you for your visit. Closing the app..".red
        break
      end

      inputs = FUNCTIONS[choice][:inputs].map do |key, value|
        input_with_message(value)
      end

      result = AdvocateService.new.send(FUNCTIONS[choice][:method], *inputs)
      output result
      display result
    end
  end

  def self.menu
    puts "Select an option:".red

    puts "1. Add an advocate"
    puts "2. Add junior advocates"
    puts "3. Add states for advocate"
    puts "4. Add cases for advocate"
    puts "5. Reject a case"
    puts "6. Display all advocates"
    puts "7. Display all cases under a state"
    puts "8. Exit"
  end

  def self.choice_with_message(message_to_show)
    Readline.readline(message_to_show.cyan, true)
  end

  def self.input_with_message(message_to_show)
    choice_with_message(message_to_show)
  end

  def self.output(object)
    puts "Output: ".green
    puts object.output
  end

  def self.display(object)
    puts "Display: ".green
    puts object.display
  end
end
