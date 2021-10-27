### Easy 1 exercises OO Programming ###

# 1.) Banner Class

# Behold this incomplete class for constructing boxed banners.

# class Banner
#   def initialize(message)
#   end

#   def to_s
#     [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#   end

#   private

#   def horizontal_rule
#   end

#   def empty_line
#   end

#   def message_line
#     "| #{@message} |"
#   end
# end

# Complete this class so that the test cases shown below work as intended. 
# You are free to add any methods or instance variables you need. However, do 
# not make the implementation details public.

# You may assume that the input will always fit in your terminal window.

class Banner
  def initialize(message)
    @message = message
  end
  
  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end
  
  private
  
  def horizontal_rule
    symbol = "-"
    "+-#{symbol * (@message.size)}-+"
  end
  
  def empty_line
    space = ' '
    "| #{space * (@message.size)} |"
  end
  
  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

banner2 = Banner.new('')
puts banner2


# 2.) What's the Output?

# Take a look at the following code:

class Pet
  attr_reader :name
  
  def initialize(name)
    @name = name.to_s
  end
  
  def to_s
    @name = upcase!
    "My name is #{@name}."
  end
end

# What does this code print? Fix this class so that there are no surprises waiting
# in store for the unsuspecting developer.

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name # => 'Fluffy'
puts fluffy # => 'My name is FLUFFY'
puts fluffy.name # => 'FLUFFY'
puts name # => 'FLUFFY'


# Fixed code below:

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name #=> 'Fluffy'
puts fluffy #=> 'My name is FLUFFY.'
puts fluffy.name #=> 'Fluffy'
puts name #=> 'Fluffy'


# 3.) Fix the Program - Books (Part 1)

# Complete this program so that it produces the expected output:

class Book
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)


# Revised code below:

class Book
  
  attr_reader :author, :title
  
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)


# 4.) Fix the Program - Books (Part 2)

# Commplete this program so that it produces the expected output:

class Book
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# Revised code bellow:

class Book
  
  attr_accessor :title, :author
  
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)


# 5.) Fix the Program - Persons

# Complete this program so that it produces the expected output:

class Person
  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person

# Revised code below:

class Person
  
  attr_writer :first_name, :last_name
  
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def to_s
    "#{@first_name.capitalize} #{@last_name.capitalize}"
  end
end

person = Person.new('john', 'doe')
puts person #=> "John Doe"

person.first_name = 'jane'
person.last_name = 'smith'
puts person #=> "Jane Smith"


# 6.) Fix the Program - Flight Data

class Flight
  attr_accessor :database_handle
  
  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# Revised code:

class Flight
  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# 7.) Buggy Code - Car Mileage

# Fix the following code so it works properly:

class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    mileage = total
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678


# Revised code below:

class Car
  attr_accessor :mileage
  
  def initialize
    @mileage = 0
  end
  
  def increment_mileage(miles)
    @mileage += miles
  end
  
  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage #=> 5678

# 8.) Rectangles and Squares

# Given the following class:

class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end


# Write a class called Square that inherits from Rectangle, and is used like 
# this:

class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

class Square < Rectangle
  def initialize(side)
    super(side, side)
  end
end

square = Square.new(5)
puts "area of square = #{square.area}" #=> area of square = 25

# 9.) Complete the Program - Cats!

# Consider the following program.

class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

# Update this code so that when you run it, you see the following output:

# My cat Pudding is 7 years old and has black and white fur.
# My cat Butterscotch is 10 years old and has tan and white fur.


# Revised code below:

class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, color)
    super(name, age)
    @color = color
  end
  
  def to_s
    "My cat #{@name} is #{@age} years old and has #{@color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')

butterscotch = Cat.new('Butterscotch', 10, 'tan and white')

puts pudding, butterscotch
#=> My cat Pudding is 7 years old and has black and white fur.
#=> My cat Butterscotch is 10 years 


# 10.) Refactoring Vehicles

# Consider the following classes:

# class Car
#   attr_reader :make, :model
  
#   def initialize(make, model)
#     @make = make
#     @model = model
#   end
  
#   def wheels
#     4
#   end
  
#   def to_s
#     "#{make} #{model}"
#   end
# end

# class Motorcycle
#   attr_reader :make, :model
  
#   def initialize(make, model)
#     @make = make
#     @model = model
#   end
  
#   def wheels
#     2
#   end
  
#   def to_s
#     "#{make} #{model}"
#   end
# end

# class Truck
#   attr_reader :make, :model, :payload

#   def initialize(make, model, payload)
#     @make = make
#     @model = model
#     @payload = payload
#   end
  
#   def wheels
#     6
#   end
  
#   def to_s
#     "#{make} #{model}"
#   end
# end

# Refactor these classes so they all use a common superclass, and inherit behavior as needed.


class Vehicle
  attr_reader :make, :model
  
  def initialize(make, model)
    @make = make
    @model = model
  end
  
  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end
