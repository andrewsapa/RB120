## Easy 2 Exercises OO Programming ##


# 1.) Fix the Program - Mailable

# Correct the following program so it will work properly. Assume that the 
# Customer and Employee classes have complete implementations; just make the 
# smallest possible change to ensure that objects of both types have access to 
# the print_address method.

module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  attr_reader :name, :address, :city, :state, :zipcode
end

betty = Customer.new
bob = Employee.new
betty.print_address
bob.print_address

# Revised code below:

module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  attr_reader :name, :address, :city, :state, :zipcode
  
  def initialize(name, address, city, state, zipcode)
    @name = name
    @address = address
    @city = city
    @state = state
    @zipcode = zipcode
  end
  
  include Mailable
end

class Employee
  attr_reader :name, :address, :city, :state, :zipcode
  
  def initialize(name, address, city, state, zipcode)
    @name = name
    @address = address
    @city = city
    @state = state
    @zipcode = zipcode
  end
  
  include Mailable
end

betty = Customer.new('Betty', '34th East St', 'Dallas', 'TX', '75002')
bob = Employee.new('Bob', '94 West Blaine St.', 'Baltimore', 'MD', '21201')

betty.print_address
bob.print_address


# 2.) Fix the Program - Drivable

# Correct the following program so it will work properly. Assume that the Car class 
# has a complete implementation; just make the smallest possible change to ensure
# that cars have access to the drive method.

module Drivable
  def self.drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive

# Revised code below:
# Methods in mixin modules should be defined without using self.

module Drivable
  def drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive


# 3.) Complete The Program - Houses

# Assume you have the following code:

class House
  attr_reader :private
  
  def initialize(price)
    @price = price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

# Revised code below:

class House
  attr_reader :price
  include Comparable # part of Ruby's core library
  
  def initialize(price)
    @price = price
  end
  
  def <=>(other)
    price <=> other.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1


# 4.) Reverse Engineering

# Write a class that will display:

# ABC
# xyz

# when the following code is run:

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

# Revised code below:

class Transform  
  def initialize(str)
    @str = str
  end
  
  def uppercase
    @str.upcase
  end
  
  def self.lowercase(str)
    str.downcase
  end
end


my_data = Transform.new('abc')

puts my_data.uppercase #=> ABC

puts Transform.lowercase('XYZ') #=> xyz


# 5.) What Will This Do?

# What will the following code print?

class Something
  def initialize
    @data = 'Hello'
  end
  
  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata #=> 'ByeBye'
puts thing.dupdata #=> 'HelloHello'


# 6.) Comparing Wallets

# Consider the following broken code:

class Wallet
  include Comparable
  
  def intialize(amount)
    @amount = amount
  end
  
  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)


# Modify this code so it works. Do not make the amount in the wallet accessible
# to any method that isn't part of the Wallet class. 

# Revised code:

class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end
  
  protected
  
  attr_reader :amount

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end


# 7.) Pet Shelter

# Consider the following code:

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

# Write the classes and methods that will be necessary to make this code run,
# and print the following output:

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.


class Pet
  attr_reader :animal, :name

  def initialize(animal, name)
    @animal = animal
    @name = name
  end

  def to_s
    "a #{animal} named #{name}"
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
  end

  def number_of_pets
    pets.size
  end

  def print_pets
    puts pets
  end
end

class Shelter
  def initialize
    @owners = {}
  end

  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
  end

  def print_adoptions
    @owners.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts
    end
  end
end


butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
jezzers      = Pet.new('cat', 'Jezzers')
pip          = Pet.new('cat', 'Pip')
oliver       = Pet.new('cat', 'Oliver')
rubio        = Pet.new('cat', 'Rubio')


phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')
aandrews = Owner.new('A Andrews')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.adopt(aandrews, jezzers)
shelter.adopt(aandrews, pip)
shelter.adopt(aandrews, oliver)
shelter.adopt(aandrews, rubio)
shelter.print_adoptions

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."


# 8.) Fix The Program - Expander

# What is wrong with the following code? What fix(es) would you make?

class Expander
  def initialize(string)
    @string = string
  end
  
  def to_s
    self.expand(3)
  end

  private
  
  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander

# No change neede as you can call private meethods with self as the caller since
# Ruby 2.7. 

# 9.) Moving

# You have the following classes.

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

# You need to modify the code so that this works:

mike = Person.new("Mike")

mike.walk #=> "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk #=> "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk #=> "Flash runs forward"

# You are only allowed to write one new method to do this.

# Revised code below:

class Person
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def walk
    puts "#{name} #{gait} forward."
  end
  
  private
  
  def gait
    "strolls"
  end
end

class Cat < Person
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  private
  
  def gait
    "saunters"
  end
end

class Cheetah < Person
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  private
  
  def gait
    "runs"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"


# more the answer that LS is looking for with a module
module Walkable
  def walk
    puts "#{name} #{gait} forward."
  end
end

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  include Walkable

  private

  def gait
    "strolls"
  end
end

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  include Walkable

  private

  def gait
    "saunters"
  end
end

class Cheetah
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  include Walkable

  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"


# 10.) Nobility

module Walkable
  def walk
    puts "#{self} #{gait} forward."
  end
end

class Person
  attr_reader :name
  
  include Walkable

  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  attr_reader :name
  
  include Walkable

  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  attr_reader :name
  
  include Walkable

  def initialize(name)
    @name = name
  end
  
  def to_s
    name
  end

  private

  def gait
    "runs"
  end
end

class Noble
  attr_reader :name, :title
  
  include Walkable
  
  def initialize(name, title)
    @title = title
    @name = name
  end
  
  def to_s
    title + " " + name
  end
  
  private
  
  def gait
    "struts"
  end
end

byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"

byron.name #=> "Byron"
byron.title #=> "Lord"

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"
