### Lecture: Inheritance ###

# 1. ) # 1.) Given this class:

class Dog
  def speak
    'bark!'
  end
  
  def swim
    'swimming'
  end
end

teddy = Dog.new
puts teddy.speak #=> "bark!"
puts teddy.swim # => "swimming!"

# Create a sub-class from `Dog` called `Bulldog overriding the `#swim` method to return `"can't swim!"`

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

freddy = Bulldog.new
puts freddy.swim # => can't swim!
# `#swim` method from the Bulldog class overrides the `#swim` method from it's superclass `Dog`. 



# 2.) Let's create a few more methods for our `Dog` class.

# Create a new class called `Cat`, which can do everything a dog can, except swim or fetch. Assume the methods do the exact same thing. Hint: don't just copy and paste all methods in `Dog` into `Cat` ; try to come up with some class hierarchy. 

class Dog
  def speak
    'bark!'
  end
  
  def swim
    'swimming!'
  end

  def run
    'running!'
  end
  
  def jump
    'jumping!'
  end
  
  def fetch
    'fetching!'
  end
end


class Cat < Dog
  def swim ; end # method overriding
  
  def fetch ; end # method overriding
end

cat = Cat.new
puts cat.swim
puts cat.run

# LS's answer:

class Pet # additional `Pet` class created
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end
end

class Cat < Pet
  def speak # method overriding
    'meow!'
  end
end

# To be fair, while it is uncommon among domestic cats, the Bengal cat breed does
# have an affinity to water and can be known to swim but for the sake of this 
# exercise...


# 3.) Draw a class hierarchy diagram of the classes from step #2

# Pet
    # run (all pets can run)
    # jump (all pets can jump)
    
  # Dog (Dog class inherits from the Pet class)
    # speak
    # fetch
    # swim
      
    # Bulldog (Bulldog class inherits from the Dog class)
      # swim (can't swim)
        
  # Cat (Cat class inherits from the Pet class)
    # speak
    
# 4.) What is the method lookup pat and how is it important?

# The method lookup path can be called using `#ancestors`, in which Ruby goes 
# through the class hierarchy and gives a path of
# order for methods invoked. The method look up path is stopped once the method 
# is found that is called. 

