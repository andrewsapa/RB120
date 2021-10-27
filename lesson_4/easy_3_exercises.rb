#### Lesson 4: OO Practice Problems ####

## Practice Problems: Easy 3 ##


# Question 1 -------------------------------------------------------------------

# If we have this code:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class GoodBye < Greeting
  def bye
    greet("Goodbye")
  end
end


# What happens in each of the following cases:

# case 1:
hello = Hello.new # => a new hello object is instantiated
hello.hi 
# `#hi` method is called on the object `hello` which then uses the greet method
# found in the Greeting class. The final output is 'Hello'.

# case 2:
hello = Hello.new # => a new hello object is instantiated
hello.bye
# This will return a NoMethodError because the Hello class doesn't have access
# to the Goodbye class where the `#bye` method is located.

# case 3:
hello = Hello.new # => a new hello object is instantiated
hello.greet
# This will return an argument error. The method `#greet` is called on the `hello`
# object but method `#greet` is not directly found in the Hello class so Ruby
# uses the lookup path finding the method in it's super class Greeting. The requirements
# for the `#greet` method is to provide an argument but since once is not provided
# here, that is why an error is returned. 

# case 4:
hello = Hello.new # => a new hello object is instantiated
hello.greet("Goodbye")
# `#greet` method is being called on the `hello` object with one argument `"Goodbye"`.
# No `#greet` method is found in the Hello class directly but there is access through
# inheritance to the `#greet` method found in the Greeting class. `"Goodybye"` is 
# printed. 

# case 5:
Hello.hi
# This will return a NoMethodError. The reason for this is that the method `#hi`
# is called directly on the `Hello` class. This can't happen because `#hi` is an
# instance method and not a class method. Only class methods can be directly called
# on a class. 




# Question 2 -------------------------------------------------------------------

# In the last question we had the following classes:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# If we call `Hello.hi` we get an error message. How would you fix this?

# One way that you can fix this code is by adding `self` to the `#hi` method in 
# the `Hello` class and the `#greet` method in the Greeting class. This will make
# them class methods and will respond directly to the Hello class. The output 
# will be `"Hello"`

class Greeting
  def self.greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end


puts Hello.hi # => "Hello"




# Question 3 -------------------------------------------------------------------

# When objects are created they are a separate realization of a particular class.

# Given the class below, how do we create two different instances of this class
# with separate names and ages?

# You have to call `#new` method on the `AngryCat` class two different times to create a new
# object or instance with two arguments for age and name as demonstrated below. 

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

henry = AngryCat.new(10, "Henry")
p henry # => #<AngryCat:0x000055b35168cae0 @age=10, @name="Henry">

frank = AngryCat.new(12, "Frank")
p frank # => #<AngryCat:0x000055b35168c8b0 @age=12, @name="Frank">




# Question 4 -------------------------------------------------------------------

# Given the class below, if we created a new instance of the class and then called
# `to_s` on that instance we would get something like "#<Cat:0x007ff39b356d30>"

class Cat
  def initialize(type)
    @type = type
  end
end

# How could we go about changing the `to_s` output on this method to look like this:
# `"I am a tabby cat?"`? (this is assuming that "tabby" is the `type` we passsed
# in during initialization).

# Defining a `#to_s` method to override the standard `#to_s` method like below
# will help. This way when puts the `tabby` object that was created, you tet
# "I am a tabby cat"` instead of an object id. 

class Cat
  def initialize(type)
    @type = type
  end
  
  def to_s
    "I am a #{@type} cat"
  end
end

tabby = Cat.new('tabby')

puts tabby # => "I am a tabby cat"

# After looking at LS's answer and remebering common standars it's more 
# conventional to refactor the code in the `#to_s` method to refer to a gettter
# method for type instead of the instance variable `@type`. For example: 

class Cat
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{type} cat"
  end
end

tabby = Cat.new('tabby')

puts tabby # => "I am a tabby cat"




# Question 5 -------------------------------------------------------------------

# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# What would happen if I called the methods like shown below?

tv = Television.new
tv.manufacturer #= > NoMethodError
# This will return a NoMethodError because `#manufacturer` method is a class method
# and it's being called on an instance of the class
tv.model #=> will return a model number
# The method `#model` will return a a model number of whatever you put inside the
# method body. This works because we'er calling an instance method on an an instance
# of the Television class.

Television.manufacturer # => will return manufacturer
# This will work because `#manufacturer` is a class method that is called on the 
# class Television. 
Television.model # => NoMethodError
# This will not work because you can't call an instance method like `#model` on 
# a class.




# Question 6 -------------------------------------------------------------------

# If we have a class such as the one below:

class Cat
  attr_accessor :type, :age
  
  def initialize(tye)
    @type = type
    @age = 0
  end
  
  def make_one_year_older
    self.age += 1
  end
end

# In the `#make_one_year_older` method we have used `self`. What is another way
# we could write this method so we don't have to use the `self` prefix?

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    @age += 1
  end
end

# One way we can do this is by changing `self.age` to the instance variable `@age`
# For example:

jezzers = Cat.new('tabby')
jezzers.age = 3
jezzers.make_one_year_older # => 4




# Question 7 -------------------------------------------------------------------

# What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color
  
  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end

# The keyword `return` in the method body for the class method `self.information`
# isn't needed. The string `"I want to turn on..."` is implicity returned when 
# you call this method on the Light class because it is the last line in the 
# that method body. 