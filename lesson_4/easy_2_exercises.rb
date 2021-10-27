#### Lesson 4: OO Practice Problems ####


# Question 1 -------------------------------------------------------------------

# You are given the following code:

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end
  
  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

# What is the result of executing the following code:

oracle = Oracle.new
oracle.predict_the_future

# The result will be string output from the `#predict_the_futre` method:
# # => "You will eat a nice lunch" (the ending part will be random because of the 
# the sample method.)




# Question 2 -------------------------------------------------------------------

# We have an `Oracle` class and a `RoadTrip` class that inherits from the `Oracle`
# class. 

class Oracle
  def predict_the_future
    "You will " + choices.sample 
  end
  
  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

# What is the result of the following:

trip = RoadTrip.new
trip.predict_the_future # => "You will <a_trip>"

# Because the RoadTrip class inherits behaviors from it's superclass Oracle, the
# instance trip has access to the instance methods in Oracle. Because the instance
# method `#choices` is created in RoadTrip and has the same name as the `#choices`
# instance method in Oracle, the method in RoadTrip overrides the one in Oracle 
# during the lookup path Ruby takes. Finally, `#sample` is called on choices and returns
# a random string from the array. 




# Question 3 -------------------------------------------------------------------

# How do you find where Ruby will look for a method when that method is called? 
# How can you find an object's ancestors?

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

# The lookup path will tell you by looking at the class itself. You can look at
# an object's ancestors by calling the method `#ancestors`.

# What is the lookup chain for Orange and HotSauce?

# Orange
# Taste
# Object
# PP::ObjectMixin
# Kernel
# BasicObject


# HotSauce
# Taste
# Object
# PP::ObjectMixin
# Kernel
# BasicObject



# Question 4 -------------------------------------------------------------------

# What could you add to this class to simplify it and remove two methods from 
# the class definition while still maintaining the same functionality?

class BeesWax
  def initialize(type)
    @type = type
  end
  
  def type
    @type
  end
  
  def type=(t)
    @type = t
  end
  
  def describe_type
    puts "I'm a #{@type} of Bees Wax"
  end
end


# You could get rid of the getter and setter method `type`, that has been 
# written manually, and replace it with `attr_accessor :type`  below:

class BeesWax
  attr_accessor :type
  
  def initialize(type)
    @type = type
  end
  
  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

# Also, according to LS's answer, it's standard practice to replace intance variables
# with the method name if there is a getter method avaialable. For example:

# change the @type instance variable
def describe_type
  puts "I am a #{@type} of Bees Wax"
end

# to type (remove the @ symbol to refer to the getter method)
def describe_type
  puts "I am a #{type} type of Bees Wax"
end




# Question 5 -------------------------------------------------------------------


# There are a number of variables listed below. What are the different types and 
# how do you know which is which?


# This is a local variable. We know this because it's all lower case with no prefixed symbols.
excited_dog = "excited dog"

# This is an instance variable because of the `@` symbol.
@excited_dog = "excited dog"

# This is a class variable because of the `@@` symbol.
@@excited_dog = "excited dog"



# Question 6 -------------------------------------------------------------------

# If I have the following class:

class Television
  def self.manufacturer
    puts "class method"
  end
  
  def model
    # method logic
  end
end

# Which one of these is a class method (if any) and how do you know? How would
# you call a class method?

# The keyword `self` before the method name in `self.manufacturer` tells us that
# this is a class method.

# You call the method name directly on the class. For example:

class Television
  def self.manufacturer
    puts "I'm a class method!"
  end
  
  def model
    # method logic
  end
end


Television.manufacturer # => I'm a class method!"




# Question 7 -------------------------------------------------------------------

# If we have a class such as the one below:

class Cat
  @@cats_count = 0
  
  def initialize(type)
    @type = type
    @age = 0
    @@cats_count += 1
  end
  
  def self.cats_count
    @@cats_count
  end
end

# Explain what the @@cats_count variable does and how it works. What code would you
# need to write to test your theory?

# The @@cats_count is class variable and is accessible by the Cat class. The 
# @@cats_count keeps track of how many instances or objects of the Cat class are 
# created. You can access it when you call the class method `self.cats_count`. 
# For example: 

p Cat.cats_count # => 0

Cat.new('tabby')
Cat.new('bengal')

p Cat.cats_count # => 2



# Question 8 -------------------------------------------------------------------

# If we have this class:

class Game
  def play
    "Start the game!"
  end
end

# And another class:

class Bingo
  def rules_of_play
    # rules of play
  end
end

# What can we add to the Bingo class to allow it to inherit the play method from 
# the Game class? 

# You can add the `<` symbol follow by the class Game after the Bingo class on 
# same line. For example:


class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    # rules of play
  end
end




# Question 9 -------------------------------------------------------------------

# If we have this class:

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# What would happen if we added a `play` method to the `Bingo` class, keeping in
# mind that there is already a method of this name in the `Game` class that the
# `Bingo` class inherits from. 

# If a `play` method was added to to the `Bingo` class, this would be called
# method overriding and the `play` method would be used first instead of the `play`
# method in the `Game` class. 




# Question 10 ------------------------------------------------------------------

# What are the benefits of using OOP in Ruby? Think of as many as you can.

# facilitation of DRY (Do not repeate yourself)
# easier to expand the program as programs become more complex
# esaiser to debug as programs become more complex
# makes your code more secure with encapsulation


# LS's answer:

# Creating objects allows programmers to think more abstractly about the code they are writing.

# Objects are represented by nouns so are easier to conceptualize.

# It allows us to only expose functionality to the parts of code that need it, 
  # meaning namespace issues are much harder to come across.

# It allows us to easily give functionality to different parts of an application without duplication.

# We can build applications faster as we can reuse pre-written code.

# As the software becomes more complex this complexity can be more easily managed.
