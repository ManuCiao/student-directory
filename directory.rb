@students = [] # an empty array accessible to all methods

## PRINT MENU ##
def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
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
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

## INPUT STUDENTS ##
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
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:gender], student[:nationality]]
    csv_line = student_data.join(", ")
    file.puts csv_line
  end
  file.close
end

## LOAD STUDENTS ##
def load_students
  file = File.open("students.csv","r")
  file.readlines.each do |line|
  name, cohort, gender, nationality = line.chomp.split(', ')
    @students << {name: name, cohort: cohort, gender: gender, nationality: nationality.to_sym}
  end
  file.close
end

## TRY LOAD STUDENTS ##
def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

#8.2
def start_with(students) 
  puts "Call Students'names with the initial letter:"
  letter = gets.chomp
  @students.each.with_index(1) do |student, index|
    if student[:name][0] == letter
      puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"      
    break
    end
  end
end

#8.3
def short_name_12(students)
  puts "Call Students'names that are shorten than 12 characthers!"
  @students.each.with_index(1) do |student, index|
    if student[:name].length < 12
      puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"      
    end
  end
end

#8.4
def print_while(students)
  index = 0
  while index < @students.length
    puts "#{index + 1}. #{students[index][:name]} (#{students[index][:cohort]} cohort)"      
    index += 1
  end
end

#8.8
def group_by_cohort(students)
  
    #puts "#{students.group_by {|s, v| s[:Cohort]}.map{|s,v| puts "The #{s} Cohort has: "}}" + "\n" + "#{s[:Name]}, #{s[:Gender]}, #{s[:Nationality]}"   
    puts @students.group_by {|s,v| s[:Cohort]}.map{|s,v| [s,v]}
    #puts "#{s[:Name]} - (#{s[:Cohort]} cohort), #{s[:Gender]}, #{s[:Nationality]}"      
      
end

#nothing happens until we call the methods
#@students = input_students
#print_header
#print_student_list
#start_with
#short_name_12
#print_while
#puts ''
#group_by_cohort
#puts ''
#print_footer
try_load_students
interactive_menu
