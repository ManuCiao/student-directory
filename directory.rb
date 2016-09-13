def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do  
    # add the student hash to the array
    students << {name: name, cohort: :September}
    puts "Now we have #{students.count} students"
    puts "Please keep entering more names of the students or hit return twice to exit"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students

end

def print_header
  puts "The students of my cohort at Makers Academy"
  puts "-------------"
end
#8.1- Add the each.with_index(1) to start the list of students from 1  
#8.2 - Only print the students whose name begins with a specific letter
def print(students)
    students.each.with_index(1) do |student, index|
      puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"      
    end
end

#8.1- Add the each.with_index(1) to start the list of students from 1  
#8.2 - Only print the students whose name begins with a specific letter
#8.3 - Only print the students whose name is shorter than 12 characters
def start_with(students)
  puts "Call Students'names with the initial letter:"
  letter = gets.chomp
  students.each.with_index(1) do |student, index|
    if student[:name][0] == letter
      puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"      
    end
  end
end

def short_name_12(students)
  quit if students.empty?
  puts "Call Students'names that are shorten than 12 characthers!"
  students.each.with_index(1) do |student, index|
    if student[:name].length < 12
      puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"      
    end
  end
end


def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end
#nothing happens until we call the methods
students = input_students
print_header
print(students)

#start_with(students)
#short_name_12(students)

print_footer(students)
