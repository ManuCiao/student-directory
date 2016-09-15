def input_students
  puts "Please enter the details of each student. To finish, just hit return twice"
  students = []
  default = :September
  loop do 
    details = {Name: "Assign a value", Cohort: default, Gender: "Assign a value", Nationality: "Assign a value"}
    details.each do |student, value|
      puts "Assign a value to the #{student} of each student: "
      value = gets.chomp.gsub(/\w+/, &:capitalize).to_sym
      details[student] = value if !value.empty?          
    end
    # add the student hash to the array
    students << details
    note = "Now we have #{students.count} students"
    if students.count <= 1
      puts note.chop
    else
      puts note
    end 
    puts "Please enter more Students'details. Enter Y/N"
    answer = gets.chomp.upcase
    break if answer == "N" || answer.empty?
  end
  # return the array of students
  students
end

def print_header(students)
  if students.count <= 1
    puts "The student of my cohort at Makers Academy is ".center(100)
  else
    puts "The students of my cohort at Makers Academy are ".center(100)
  end
  puts "***************".center(100)
  puts''
end

#8.1
def print(students)
  students.each.with_index(1) do |student, index|
    puts "#{index}. #{student[:Name]} - (#{student[:Cohort]} cohort), #{student[:Gender]}, #{student[:Nationality]}".center(100)      
  end
end

#8.2
def start_with(students) 
  puts "Call Students'names with the initial letter:"
  letter = gets.chomp
  students.each.with_index(1) do |student, index|
    if student[:name][0] == letter
      puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"      
    break
    end
  end
end

#8.3
def short_name_12(students)
  puts "Call Students'names that are shorten than 12 characthers!"
  students.each.with_index(1) do |student, index|
    if student[:name].length < 12
      puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"      
    end
  end
end

#8.4
def print_while(students)
  index = 0
  while index < students.length
    puts "#{index + 1}. #{students[index][:name]} (#{students[index][:cohort]} cohort)"      
    index += 1
  end
end


#8.8
def group_by_cohort(students)
  
    #puts "#{students.group_by {|s, v| s[:Cohort]}.map{|s,v| puts "The #{s} Cohort has: "}}" + "\n" + "#{s[:Name]}, #{s[:Gender]}, #{s[:Nationality]}"   
    puts students.group_by {|s,v| s[:Cohort]}.map{|s,v| [s,v]}
    #puts "#{s[:Name]} - (#{s[:Cohort]} cohort), #{s[:Gender]}, #{s[:Nationality]}"      
      
end


#9
def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end 

def print_footer(students)
  footer_title = "Overall, we have #{students.count} great students"
  if students.count <= 1
    puts footer_title.chop.center(100)
  else
    puts footer_title.center(100)
  end
end
#nothing happens until we call the methods
#students = input_students
#print_header(students)
#print(students)
#start_with(students)
#short_name_12(students)
#print_while(students)
#puts ''
#group_by_cohort(students)
#puts ''
#print_footer(students)
interactive_menu
