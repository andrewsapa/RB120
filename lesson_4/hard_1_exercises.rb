#### Lesson 4: OO Practice Problems ####



## Practice Problems: Hard 1 ##



# Question 1 -------------------------------------------------------------------

# Alyssa has been assigned a task of modifying a class that was initially created
# to keep track secret information. The new requirement calls for adding logging, 
# when clients of the class attempt to access the secret data. Here is the class
# in its current form:

class SecretFile
  attr_reader :data
  
  def initialize(secret_data)
    @data = secret_data
  end
end

# She needs to modify it so that any access to `data` must result in a log entry
# being generated. That is, any call to the class which result in data being
# returned must first call a logging class. The logging class has been supplied
# to Alyssa and looks like the following:

class SecurityLogger
  def create_log_entry
  end
end

# Hint: Assume that you can modify the `initialize` method in `SecretFile` to 
# have an instance of `SecurityLogger` be passed in as an additional argument. It
# may be helpful to review the lecture on collaborater object of this practice 
# problem.

# LS's answer:

class SecretFile
  def initialize(secret_data, logger)
    @data = secret_data
    @logger = logger
  end

  def data
    @logger.create_log_entry
    @data
  end
end




# Question 2 -------------------------------------------------------------------

# Ben Alyssa are working on a vehicle management system. So far, they have created
# classes called `Auto` and `Motorcycle` to represent automobiles and motorcycles.
# After having noticed common information and calculations they were performing
# for each type of vehicle, they decided to break out the commonality into a 
# separate class called `WheeledVehicle`. This is what their code looks like so
# far:

class WheeledVehicle
  attr_accessor :speed, :heading
  
  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end
  
  def tire_pressure(tire_index)
    @tires[tire_index]
  end
  
  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
  
  def range
    @fuel_capacity * @fuel_effiency
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30, 30, 32, 32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20, 20], 80, 8.0)
  end
end

# Now Alan has asked them to incorporate a new type of vehicle into their system -
# a `Catarman` defined as follows:

class Catamaran
  attr_reader :propeller_count, :hull_count
  attr_accessor :speed, :heading
  
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
  end

end


# This new class does not fit well with the object hierarchy defined so far. Catamarans
# don't have tires. But we still want common code to track fuel efficiency and range. Modify
# the class definitions and move code into a Moddule, as necessary, to share code among the
# `Catamaran` and the wheeled vehicles.


module TirePressure
  def tire_pressure(tire_index)
    @tires[tire_index]
  end
  
  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Vehicle
  attr_accessor :speed, :heading

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class Auto < Vehicle
  include TirePressure
  
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < Vehicle
  include TirePressure
  
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Catamaran < Vehicle
  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @num_propellers = num_propellers
    @num_hulls = num_huls
    super(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

# I took a different approach from LS's answer. I change the name of the class
# `WheeledVehicle` to `Vehicle` since technically a motorcycle, catamaran, and auto
# are examples of vehicles. I then had Catamaran inherit from Vehicle as well. 
# The module I used for things unique to autos and motorcycle involving inflating tires.

# Here is LS's answer:

module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Catamaran
  include Moveable

  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity

    # ... other code to track catamaran-specific data omitted ...
  end
end




# Question 3 ------------------------------------------------------------------

# Building on the prior vehicles question, we now must also track a basic motorboat.
# A motorboat has a single propellar and hull, but otherwise behaves similar to
# a catamaran. Therefore, creators of `Motorboat` instances don't need to specify
# number of hulls or propellars. How would you modify the vehicles code to incorporate
# a new `Motorboat` class?


module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end


class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end


class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end


class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Seacraft
  include Moveable

  attr_reader :hull_count, :propeller_count

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end
end

class Catamaran < Seacraft
end


class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # set up 1 hull and 1 propeller
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end


cat1 = Catamaran.new(3, 3, 50, 200)
p cat1
p cat1.propeller_count

motorboat1 = Motorboat.new(10, 50)
p motorboat1





# Question 4 -------------------------------------------------------------------

# The designer of the vehicle management system now want to make an adjustment for
# how the range of vehicles is calculated. For the seaborne vehicles, due to 
# prevailing ocean currents, the want to add an additional 10km range if the 
# vehicle is out of fuel. 

# Alter the code related to vehicles so tha the range for autos and motorcycles
# is still calculated as before, but for catamarans and motorboats, the range
# method will return and additional 10 km. 



# I altered the `Moveable` module to include two different ranges, `wheeled_vehicle_range`
# for the motorcycle and the auto and then `secraft_range` that adds 10 km to the
# range. 

module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def wheeled_vehicle_range
    @fuel_capacity * @fuel_efficiency
  end
  
  def seacraft_range
    (@fuel_capacity * @fuel_efficiency) + 10
  end
end


class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end


class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end


class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Seacraft
  include Moveable

  attr_reader :hull_count, :propeller_count

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end
end


class Catamaran < Seacraft
end


class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # set up 1 hull and 1 propeller
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end


cat = Catamaran.new(3, 3, 50, 200)
p cat.seacraft_range # => 10010

moto_boat1 = Motorboat.new(20, 50)
p moto_boat1.seacraft_range # => 1010

moto1 = Motorcycle.new
p moto1.wheeled_vehicle_range # => 640.0