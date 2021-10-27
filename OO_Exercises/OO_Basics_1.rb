### Object Oriented Basics: Classes and Objects 1 ###


# 1.) Find the Class

# Update the following code so that, instead of printing the values, each statement 
# prints the name of the class to which it belongs.

puts "Hello".class #=> String
puts 5.class #=> Integer
puts [1, 2, 3].class #=> Array


# 2.) Create the Object

# Using the code from the previous exercise, create an instance of Cat and assign 
# it to a variable named kitty.

class Cat
end

kitty = Cat.new


# 3.) What are you?

# Using the code from the previous exercise, add an `#initialize` method that prints
# "I'm a cat!" when a new `Cat` object is initialized.


class Cat
  def initialize
    puts "I'm a cat"
  end
end

kitty = Cat.new


# 4.) Hello, Sophie!(part 1)

# Using the code from the previous exercise, adda a parameter to #intialize that
# provides a name for the `Cat` object. Use an instance variable to print a greeting
# with the provided name.(You can remove the code that displays "I'm a cat!")

class Cat
  def initialize(name)
    @name = name
    puts "Hello! My name is #{@name}!"
  end
end

kitty = Cat.new('Sophie')


# 5.) Reader

# Using the code from the previous exercise, add a getter method named `#name`
# and invoke it in place of `@name` in `#greet`.

class Cat
  
  attr_reader :name
  
  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{@name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet

# or

class Cat
  def initialize(name)
    @name = name
  end
  
  def name
    @name
  end

  def greet
    puts "Hello! My name is #{@name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet


# 6.) Writer

# Using the code from the previous exercise, add a setter method name `#name=`. Then, 
# rename `kitty` to 'Luna' and invoke the `#greet` again.

class Cat
  
  attr_reader :name
  attr_writer :name
  
  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
puts kitty.name

kitty.name = 'Luna'
kitty.greet

#or

class Cat
  
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def name=(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
puts kitty.name

kitty.name = 'Luna'
kitty.greet


# 7.) Accessor

# Using the code from the previous execise, replace the getter and setter using
# Ruby shorthand

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.name = 'Luna'
kitty.greet


# 8.) Walk the Cat

# Using the following code, create a module named `Walkable` that containers a
# method named `#walk`. This method should print "Let's go for a walk!" when invoked.
# Include `Walkable` in `Cat` and invoke `#walk` on `kitty`.

module Walkable
  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  include Walkable
  
  attr_reader :name
  
  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
  
  include Walkable
end

kitty = Cat.new('Sophie')
kitty.greet