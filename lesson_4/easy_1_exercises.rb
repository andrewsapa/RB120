#### Lesson 4: OO Practice Problems ####


## Easy 1 ##


# Question 1 -------------------------------------------------------------------
# Which of the following are objects in Ruby? If they are objects, how can 
# you find out what class they belong to?

# 1. true
# 2. "hello"
# 3. [1, 2, 3, "happy days"]
# 4. 142

# All of the above, 1-4, are considered objects. True is an object of the TrueClass. 
# "hello" is an object of the String class. [1, 2, 3, "happy days"] is an object
# an object of the Array class and 142 is an object of the Integer class. You can
# find this it out by using the method `#class`. 



# Question 2 -------------------------------------------------------------------
# If we have a Car class and a Truck class and we want to be able to go_fast, 
# how can we add the ability for them to go_fast using the module Speed? How can 
# you check if your Car or Truck can now go fast?


module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed

  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Truck

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

Truck.new.go_fast #=> I am a Truck and going super fast!
Car.new.go_fast #=> I am a Car and going super fast!

# The keywword include followed by the name of the the module Speed, need to
# be adde to each class that you want to be able to access the module Speed. 
# Next, to check if it works. You can instantiate a new object from the Truck and/or
# Car class with the `#new` method and then chain the `#go_fast` method name from
# module Speed to check if it works. 




# Question 3 -------------------------------------------------------------------

# In the last question we had a module called `Speed` which contained `#go_fast` 
# method. We included this module in the `Car` class as shown below. 

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  
  def go_slow
    puts "I am safe and driving slow."
  end
end

# When we called the go_fast method from an instance of the `Car` class (as shown below)
# you might have noticed that the `String` printed when we go fast includes the name
# of the type of vehicle we are using. How is this done?

small_car = Car.new
small_car.go_fast
# => "I am a Car and going super fast!"

# This is done because the self.classs. `self` in this case refers to the object
# created by `Car.new` that is referred to by the local variable `small_car`. The 
# method `#class` is then called on this object which returns `Car` because the 
# object `small_car` is part of the `Car` class. A string representation of the class
# of the object is returned because of the interpolation within the string. 




# Question 4 -------------------------------------------------------------------

# If we have a class AngryCat how do we create a new instance of this class?

# The AngryCat class might look something like this:

class AngryCat
  def hiss
    puts "Hisssss!!"
  end
end

AngryCat.new #=> #<AngryCat:0x000055ff70bb72c0>
# This will create a new instance or object of the class AngryCat. 



# Question 5 -------------------------------------------------------------------

# Which of these two classess has an instance variable and how do you know? 

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# The Pizza class has instance variable `@name` initialized in the `initialize`
# constructor/instance method. We know that `@name` is an instance variable becuase
# of the `@` symbol. 

# Furthermore, according LS's answer we can use the method `#instance_variables'
# and call this method on instances created by the Pizza class and the Fruit class
# to double check that only the Pizza class has an instance variable

# e.g.
hot_pizza = Pizza.new("cheese")
orange    = Fruit.new("apple")

hot_pizza.instance_variables
# => [:@name]
orange.instance_variables
# => []




# Question 6 -------------------------------------------------------------------

# What could we add to the class below to access the instance variable `@volume` ?

class Cube
  def initialize(volume)
    @volume = volume
  end
end

# You could at a getter method to access the `@volume` variable. You could do this
# by adding `attr_reader` or by adding the code below. 

def volume
  @volume
end

cube1 = Cub.new(34)
cube1.volume #=> 34

# Per LS's answer you can also use the metho `#instance_variable_get` like below, 
# although it's generally best to not directly access instance variables in this
# manner. 

cube1 = Cube.new(34)
cube1.instance_variable_get("@volume") #=> 34




# Question 7 -------------------------------------------------------------------

# What is the defaul return value of `to_s` when invoked on an object? Where could 
# you go to find out if you want to be sure?

# The default `to_s` prints the object's class and an encoding of the object id.
# You can find this information in the Ruby Docs on the the instance method `#to_s` under
# the Object class. 



# Question 8 -------------------------------------------------------------------

# If we have a class such as the one below:

class Cat
  attr_accessor :type, :age
  
  def initialize(type)
    @type = type
    @age = 0
  end
  
  def make_one_year_older
    self.age += 1
  end
end


# `self` refers to any object or instance created by the Cat class. 

# e.g.
jezzers = Cat.new
jezzers.make_one_year_older #=> 1
# `self` is the object that `jezzers` references. 




# Question 9 -------------------------------------------------------------------

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

# In the name of the cats_count method we have used self. What does self refer 
# to in this context?

# `self` in this context refers to the Cat class and it makes this method a 
# class method. 

# e.g.
Cats.cats_count #=> 0
# do not need to create and instance here because `cats_count` is availabe at the
# class level. 

Cat.new('tabby')
Cat.new('abyssinian')
Cat.new('bengal')

Cat.cats_count #=> 3




# Question 10 ------------------------------------------------------------------

# If we have the class below, what would you need to call to create a new instance
# of this class. 

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

# To create a new instance/ object of this class we would need to call the method
# `#new` on the Bag class and provide a color and material argument.

Bag.new('red', 'nylon') #=> #<Bag:0x0000557dc8cdd4d0 @color="red", @material="nylon">
# creates a new instance