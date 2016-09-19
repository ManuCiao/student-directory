require 'CSV'

@students = [] # an empty array accessible to all methods
#PRINT THE SOURCE CODE:
#puts File.read(__FILE__)

## PRINT MENU ##
def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "5. Print the source code"
  puts "9. Exit" # 9 because we'll be adding more items  
end

## INTERACTIVE MENU ##
def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

## PROCESS - SELECTION ##
def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "5"
    puts File.read(__FILE__)
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

## INPUT STUDENTS WITH DEFAULT VALUES##
def input_students
  puts "Please enter the details of each student. To finish, just hit return twice"
  default = :September
  loop do 
    details = {name: "Assign a value", cohort: default, gender: "Assign a value", nationality: "Assign a value"}
    details.each do |student, value|
      puts "Assign a value to the #{student} of each student: "
      value = STDIN.gets.chomp.gsub(/\w+/, &:capitalize).to_sym
      details[student] = value if !value.empty?          
    end
    # add the student hash to the array
    @students << details
    note = "Now we have #{@students.count} students"
    if @students.count <= 1
      puts note.chop
    else
      puts note
    end 
    puts "Please enter more Students'details. Enter Y/N"
    answer = STDIN.gets.chomp.upcase
    break if answer == "N" || answer.empty?
  end
  # return the array of students
  @students
end

##  APPEND STUDENTS  ##
def students_append(name, cohort, gender, nationality)
  @students << {name: name, cohort: cohort, gender: gender, nationality: nationality}
end

## SHOW STUDENTS ##
def show_students
  print_header
  print_student_list
  print_footer
end

## PRINT HEADER ##
def print_header
  if @students.count <= 1
    puts "The student of my cohort at Makers Academy is ".center(100)
  else
    puts "The students of my cohort at Makers Academy are ".center(100)
  end
  puts "***************".center(100)
  puts''
end

## PRINT STUDEDNT LIST ##
def print_student_list
  @students.each.with_index(1) do |student, index|
    puts "#{index}. #{student[:name]} - (#{student[:cohort]} cohort), #{student[:gender]}, #{student[:nationality]}".center(100)      
  end
end

## PRINT FOOTER ##
def print_footer
  footer_title = "Overall, we have #{@students.count} great students"
  if @students.count <= 1
    puts footer_title.chop.center(100)
  else
    puts footer_title.center(100)
  end
end

## PRINT SAVE STUDENTS ##
def save_students
  puts "Give the name of the file you want to save: "
  filename = STDIN.gets.chomp
  # open the file for writing
  #file = File.open(filename, "w+")
  # iterate over the array of students
  CSV.open(filename, "w") do |doc|
    @students.each { |student| doc << [student[:name], student[:cohort], student[:gender], student[:nationality]] }
  end
  #file.close
end

## LOAD STUDENTS ##
def load_students(filename = "students.csv")
   CSV.foreach(filename) do |line|
     name, cohort, gender, nationality = line
     students_append(name, cohort, gender, nationality)
    end
  puts "Loaded #{@students.count} students from #{filename}"
end

#nothing happens until we call the methods

interactive_menu
