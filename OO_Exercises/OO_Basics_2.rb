### OO Basics: Classes and Objects 2 ###



# 1.) Generic Greeting (Part 1)

# Modify the following code so that "Hello! I'm a cat!" is printed when
# `Cat.generic_greeting` is invoked.

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!!"
  end
end

Cat.generic_greeting

# Further Exploration
# What happens if you run kitty.class.generic_greeting? Can you explain this result?

# `kitty.class.generic_greeting` will print out the same thing, "Hello! I'm a cat!".
# The reason why this happens is because `#class` is called on `kitty` which returns the class
# `Cat`. `#generic_greeting is then called on the class `Cat`.


# 2.) Hello, Chloe!

# Using the following code, add an instance method named `#rename` the renames `kitty`
# when invoked.

class Cat
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def rename(new_name)
    @name = new_name
  end
end

kitty = Cat.new('Sophie')
puts kitty.name
kitty.rename('Chloe')
puts kitty.name

# or

class Cat
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def rename(new_name)
    self.name = new_name
  end
end

kitty = Cat.new('Sophie')
puts kitty.name
kitty.rename('Chloe')
puts kitty.name


# 3.) Identify Yourself(Part 1)

# Using the following code, add a method named #identify that returns its calling object.

class Cat
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def identify
    self
  end
end

kitty = Cat.new('Sophie')
p kitty.identify
puts kitty.inspect
p kitty

# 4.) Generic Greeting(Part 2)

# Using the following code, add two methods: ::generic_greeting and #personal_greeting. 
# The first method should be a class method and print a greeting that's generic 
# to the class. The second method should be an instance method and print a greeting 
# that's custom to the object.

class Cat
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
  
  def personal_greeting
    puts "Hello! I'm a cat and my name is #{@name}!"
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting #=> "Hello! I'm a cat!"
kitty.personal_greeting #=> "Hello! I'm a cat and my name is Sophie!"

# 5.) Counting Cats

# Using the following code, create a class named Cat that tracks the number of 
# times a new Cat object is instantiated. The total number of Cat instances should 
# be printed when ::total is invoked.

class Cat
  @@running_total = 0
  
  def initialize
    @@running_total += 1
  end
  
  def self.total
    puts @@running_total
  end
end

kitty1 = Cat.new
kitty2 = Cat.new

Cat.total #=> 2

# 6.) Colorful Cat

# Using the following code, create a class named `Cat` that prints a greeting when
# #greet is invoked. The greeting should include the name and color of the cat. Use
# a constant to define the color. 

class Cat
  attr_accessor :name
  
  CAT_COLOR = 'blue'
  
  def initialize(n)
    @name = n
  end
  
  def greet
    puts "Hello! My name is #{@name} and I'm #{CAT_COLOR}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet

# 7.) Identify Yourself(Part 2)

# Update the following code so that it prints "I'm Sophie!" when it invokes `puts kitty`.

class Cat
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def to_s
    "I'm #{name}!"
  end
end

kitty = Cat.new('Sophie')
puts kitty #=> I'm Sophie!


# 8.) Public Secret

class Person
  attr_writer :secret
  attr_reader :secret
end

person1 = Person.new
person1.secret = "Shh.. this is a secret!"
puts person1.secret #=> "Shh.. this is a secret!"

#or

class Person
  def secret=(secret)
    @secret = secret
  end
  
  def secret
    @secret
  end
end

person1 = Person.new
person1.secret = "Shh.. this is a secret!"
puts person1.secret #=> "Shh.. this is a secret!"


# 9.) Private Secret

class Person
  attr_writer :secret
  
  def share_secret
    puts @secret
  end
  
  private
  
  attr_reader :secret
end

person1 = Person.new
person1.secret = "Shh.. this is a secret!"
person1.share_secret #=> "Shh.. this is a secret!"


# 10.) Protected Secret

class Person
  attr_writer :secret
  
  def compare_secret(person2)
    secret == person2.secret
  end
  
  protected
  
  attr_reader :secret
end

person1 = Person.new
person1.secret = "Shh.. this is a secret!"

person2 = Person.new
person2.secret = "Shh.. this is a different secret!"

puts person1.compare_secret(person2) #=> false