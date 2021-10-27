#### Lesson 4: OO Practice Problems ####

## Medium 1 ##

# Ben asked Alyssa to code review the following code:

class BankAccount
  attr_reader :balance
  
  def initialize(starting_balance)
    @balance = starting_balance
  end
  
  def positive_balance?
    balance >= 0
  end
end

# Alyssa glanced over the code quickly and said - "It looks fine, except that you
# forgot to put the @ before balance when you refer to the balance instance 
# variable in the body of the positive_balance? method."

# "Not so fast", Ben replied. "What I'm doing here is valid - I'm not missing an @!"

# Who is right, Ben or Alyssa, and why?


# I would say that Ben is more correct here. First of all, either way you get the
# same solution when you call `#positive_balance?` on an instance. The reason why
# Ben is more correct is that a getter method `balance` has been created via 
# `attr_reader :balance`. This getter method already returns the instance variable
# `@balance`. The `balance` in the `#positive_balance?` method is referring to 
# the getter method and not the instance variable. I have learned that its is a more
# common convention to refer to a getter method to access an instance variable
# than the directly the instance variable itself. 



# Question 2 -------------------------------------------------------------------

# Alan created the following code to keep track of items for a shopping cart 
# application he's writing:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

# Alyssa looked at the code and spotted a mistake. "This will fail when `update_
# quantity` is called," she says.

# Can you spot the mistake and how to address it ?

# The issue is in the instance method `update_quantity`. The reassignment of 
# `quantity` needs to refer to the instance variable but it doesn't. This is the
# problem. In the refactored code below, you can see how changing `quantity` to 
# an instance variable makes the code not fail. Without this update when youc call
# `update_quantity` on the instance `entry1` you still get 10 instead of the 
# desired updated quantity of 4. 

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    @quantity = updated_count if updated_count >= 0
  end
end

entry1 = InvoiceEntry.new("iPhone", 10)
entry1.update_quantity(4) # => 4




# Question 3 -------------------------------------------------------------------

# In the last question Alan showed Alyssa this code which keeps track of items
# for a shopping cart application:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# Alyssa noticed that this will fail when update_quantity is called. Since 
# quantity is an instance variable, it must be accessed with the @quantity 
# notation when setting it. One way to fix this is to change `attr_reader` to 
# `attr_accessor` and change quantity to `self.quantity`.

# Is there anything wrong with fixing it this way?

# We don't really want access or give access to a setter method for `product_name` 
# as product names may not necessarily change but rather a quantity of a certain 
# product may change. You're also providing access to the `quantity` setter method
# to change the quantity without having to go through the `update_quantity_count`
# method. 




# Question 4 -------------------------------------------------------------------

# Let's practice creating an object hierarchy.

# Create a class called Greeting with a single instance method called greet that
# takes a string argument and prints that argument to the terminal.

# Now create two other classes that are derived from Greeting: one called Hello 
# and one called Goodbye. The Hello class should have a hi method that takes no 
# arguments and prints "Hello". The Goodbye class should have a bye method to 
# say "Goodbye". Make use of the Greeting class greet method when implementing 
# the Hello and Goodbye classes - do not use any puts in the Hello or Goodbye 
# classes.

class Greeting
  def greet(string)
    puts string
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

goodbye = Goodbye.new
hello = Hello.new

goodbye.bye # => Goodbye
hello.hi # => Hello



# Question 5 -------------------------------------------------------------------

# You are given the following class that has been implemented:

class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1 # => "Plain"

puts donut2 # => "Vanilla"

puts donut3 # => "Plain with sugar"

puts donut4 # => "Plain with chocolate sprinkles"

puts donut5 # => "Custard with icing"


# Write additional code for KrispyKreme such that the puts statements will work 
# as specified above.


class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
  
  def to_s
    @filling_type == nil ? @filling_type = 'Plain' : @filling_type
    output = "#{@filling_type} with #{@glazing}"
    output.split.size == 2 ? output.split[0] : output
  end
end




# Question 6 -------------------------------------------------------------------

# If we have these two methods in the `Computer` class:

class Computer
  attr_accessor :template
  
  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

class Computer
  attr_accessor :template
  
  def create_template
    self.template = "template 14231"
  end
  
  def show_template
    self.template
  end
end

# What is the difference in the way the code works?


class Computer
  attr_accessor :template
  
  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

# In the code above, the instance variable `@template` references the string 
# `"template 14321"`. The `show_template` method returns the return value of the
# getter method `template`. 

class Computer
  attr_accessor :template
  
  def create_template
    self.template = "template 14231"
  end
  
  def show_template
    self.template
  end
end

# In the code above, `self.template` also references the instance variable 
# `@template` which references the string `"template 14321"`. There is no 
# difference in the results of each code only the way in which the code is 
# executed.  





# Question 7 -------------------------------------------------------------------

# How could you change the method name below so that the method name is more
# clear and less repetitive?

class Light
  attr_accessor :brightness, :color
  
  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def light_status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end
end


class Light
  attr_accessor :brightness, :color
  
  def initialize(brithness, color)
    @brightness = brightness
    @color = color
  end

  def light_status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end
end

# My answer:

# I'll got to be honest I'm not sure what repetitiveness there is but I'll take 
# a stab and say you could change the getter/setter methods to `lumens`? But 
# then of course you get the repetitivness of `lumens` but it is maybe more 
# scientific. Unless of course,we're talking about the `light_status` method 
# which there is only of so I'm not sure how that is repetitive.


# LS's answer:

# Currently the method is defined as light_status, which seems reasonable. But 
# when using or invoking the method, we would call it like this: 
# `my_light.light_status`. Having the word "light" appear twice is redundant. 
# Therefore, we can rename the method to just status, and we can invoke it like 
# as `my_light.status`. This reads much better -- remember, you're writing code 
# to be readable by others as well as your future self.
