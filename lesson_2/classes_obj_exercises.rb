### Lecture: Classes and Objects ###

# 1.) Given the below usage of the `Person` class, code the class definition

# class Person
#   attr_accessor :name
  
#   def initialize(name)
#     @name = name
#   end
# end

# bob = Person.new('bob')
# bob.name #=> 'bob'
# bob.name = 'Robert' 
# bob.name #=> 'Robert'

# 2.) Modify the class definition from above to facilities the following methods.
# Note that there is no `name=` setter method now.

# class Person
#   attr_accessor :first_name, :last_name, :name

#   def initialize(full_name)
#     parts = full_name.split
#     @first_name = parts.first
#     @last_name = parts.size > 1 ? parts.last : ''
#   end

#   def name
#     "#{first_name} #{last_name}"
#   end
# end

# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# p bob.last_name = 'Smith'
# p bob.name 

# 3.) Now create a smart `name=` method that can take just a first name or a 
# full name, and knows how to set the `first_name` and `last_name` appropriately. 

class Person
  attr_accessor :first_name, :last_name
  
  def initialize(full_name) #constructor method
    name_array = full_name.split
    @first_name = name_array[0]
    @last_name = name_array.size > 1 ? name_array[-1] : ''
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def name=(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name  


# 4.) Using the class definition from step #3, let's create a few more people -- that is, Person objects. 

class Person
  attr_accessor :first_name, :last_name
  
  def initialize(full_name) #constructor method
    name_array = full_name.split
    @first_name = name_array[0]
    @last_name = name_array.size > 1 ? name_array[-1] : ''
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def name=(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end
  
  def ==(other_name)
    self.name == other_name.name
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

# If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?

# You can either create a an `==` instance method for the `Person` class like so:

def ==(other_name)
  self.name == other_name.name
end

p bob == rob #=> true

# or you can simply call `#name` instance method on the objects `bob` and `rob`.

p bob.name == rob.name #=> true


# 5.) Continuing with our Person class definition, what does the below print out?

class Person
  attr_accessor :first_name, :last_name
  
  def initialize(full_name) #constructor method
    name_array = full_name.split
    @first_name = name_array[0]
    @last_name = name_array.size > 1 ? name_array[-1] : ''
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def name=(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end
end

bob = Person.new('Robert Smith')
puts "The person's name is: #{bob}"

# Without running the code, I predict the the code will print out "The person's name is: " followed by an object id for the object `bob`. The reason for this is because have not called the `#name` method on the object bob. 

# After running the code:
# => The person's name is: #<Person:0x0000563ddb654770>


# LS's answer: Important to remember that when using string interpolation, Ruby automatically calls the `#to_s` instance method on `bob` here. Every object in Ruby comes with a `#to_s` inherited from the `Object` class. 


# You can fix this by changing the code a couple of ways:

puts "The person's name is: " + bob.name

# or

puts "The person's name is: #{bob.name}"

# or creating a `#to_s` method in the class

def to_s
  name # references the `name` instance method
end
