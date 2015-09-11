require 'csv'  # => true

class Todo

  def initialize(file_name)
    @file_name = file_name #Don't touch this line or var
    # You will need to read from your CSV here and assign them to the @todos variable. make sure headers are set to true
    @todos = CSV.read(@file_name, {headers: true})
  end

  def start
    loop do
      system('clear')

      puts "---- TODO.rb ----"

      view_todos

      puts
      puts "What would you like to do?"
      puts "1) Exit 2) Add Todo 3) Mark Todo As Complete"
      print " > "
      action = gets.chomp.to_i
      case action
      when 1 then exit
      when 2 then add_todo
      when 3 then mark_todo
      else
        puts "\a"
        puts "Not a valid choice"
      end
      view_todos
    end
  end

  def view_todos  #working
    puts "Unfinished"
    @todos.each_with_index do |todo, index|
      puts "#{index + 1}) #{todo["name"]}"
    end
    puts "Completed"
    @todos.each_with_index do |todo, index|
      puts "#{index + 1}) #{todo["completed"]}"
    end
  end

  def add_todo #adding to csv, not printing to screen unfinished, only adding placemarkers
    puts "Name of Todo > "
    # response = get_input  #get input
    @todos << [get_input, "no"] # all input is pushed but have to add ",no"
    # todos.csv()
  end

  def mark_todo #working
    puts "Which todo have you finished?"
    answer = get_input.to_i
    @todos[answer - 1]["completed"] = "yes" #saving a random "yes"
    save!
  end


  def todos
    @todos
  end

  private # Don't edit the below methods, but use them to get player input and to save the csv file
  def get_input
    gets.chomp
  end

  def save!
    File.write(@file_name, @todos.to_csv)
  end
end
