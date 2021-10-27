### OO Basics: Accessor Methods ###

# 1.) Reading and Writing

# Add the appropriate accessor methods to the following code.

class Person
  attr_writer :name
  attr_reader :name
  
  def intialize
    @name = name
  end
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name #=> Jessica


# or
class Person
  attr_accessor :name
  
  def intialize
    @name = name
  end
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name #=> Jessica


# or
class Person
  def intialize
    @name = name
  end
  
  def name=(name)
    @name = name
  end
  
  def name
    @name
  end
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name #=> Jessica


# 2.) Choose the Right Method

# Add the appropriate accessor methods to the following code.

class Person
  attr_accessor :name
  attr_writer :phone_number
end

person1 = Person.new
person1.name = 'Jessica'
person1.phone_number = '0123456789'
puts person1.name #=> 'Jessica'

# 3.) Access Denied

# Modify the following code so that the value of @phone_number can still be read
# as on line 10, but cannot be changed as on line 12.

class Person
  attr_reader :phone_number
  
  def initialize(number)
    @phone_number = number
  end
end

person1 = Person.new(123456789)
puts person1.phone_number

person1.phone_number = 9987654321
puts person1.phone_number
#=> 123456789
#=> NoMethodError


# 4.) Comparing Names

# Using the following code, add the appropriate accessor methods. Keep in mind that
# the last_name getter shouldn't be visible outside the class, while the first_name
# getter should be visible outside the class. 

class Person
  attr_accessor :first_name
  
  attr_writer :last_name
  
  def first_equals_last?
    first_name == last_name
  end
  
  private
  
  attr_reader :last_name
end

person1 = Person.new
person1.first_name = 'Dave'
person1.last_name = 'Smith'
puts person1.first_equals_last? #=> false
puts person1.first_name #=> Dave
puts person


# 5.) Who is Older?

# Using the following code, add the appropriate accessor methods. Keep in mind that
# @age should only be visible to instances of Person.

class Person
  attr_writer :age
  
  def older_than?(other)
    age > other.age
  end
  
  protected
  
  attr_reader :age
end

person1 = Person.new
person1.age = 17

person2 = Person.new
person2.age = 26

puts person1.older_than?(person2) #=> false


# 6.) Guaranteed Formatting

# Using the following code, add the appropriate accessor methods so that @name 
# is capitalized upon assignment.

class Person
  attr_reader :name
  
  def name=(name)
    @name = name.capitalize
  end
end

person1 = Person.new
person1.name = 'eLiZaBeTh'
puts person1.name #=> Elizabeth


# 7.) Prefix the Name

# Using the following code, add the appropriate accessor methods so that @name is
# returned with the added prefix 'Mr.'.

class Person
  attr_reader :name
  
  def name=(name)
    @name = "Mr. #{name}"
  end
end

person1 = Person.new
person1.name = 'James'
puts person1.name #=> Mr. James


# 8.) Avoid Mutation

# The following code is flawed. It currently allows @name to be modified from 
# outside the method via a destructive method call. Fix the code so that it returns 
# a copy of @name instead of a reference to it. 
class Person
  def initialize(name)
    @name = name
  end
  
  def name
    @name.dup #or #.clone
  end
end

person1 = Person.new('James')
person1.name.reverse!
puts person1.name #=> James


# 9.) Calculated Age

# Using the following code, multiply @age by 2 upon assignment, then multiply @age
# by 2 again when @age is returned by the getter method. 

class Person
  def age=(age)
    @age = age * 2
  end

  def age
    @age * 2
  end
end

person1 = Person.new
person1.age = 20
puts person1.age #=> 80


# 10.) Unexpected Change

# Modify the following code to accept a string containing a first and last name.
# The name should be split into two instance variables in the setter method, then
# joined in the getter method to form a full name. 

class Person
  attr_reader :name
  
  def name=(name)
    name = name.split
    @first_name = name[0]
    @last_name = name[1]
    @name = @first_name + ' ' + @last_name
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name #=> John Doesd