module Patterns

  # Monster -> Object
  #
  # The monster class. It delegates its calls to the monster type class.
  # This is an example of the Type Object pattern.
  # This is also an example of the concept of Object Composition over inheritance. The monster HAS a type attribute instead of inheriting one.
  # This allows us to decouple the monster from its type and stops inheritance from getting out of control in a system with many similar objects.
  class Monster

    attr_accessor :monster_type
    # Initializes the monster class
    #
    # * +monster_type+ - The type of the monster that has a corresponding json file
    #
    # Examples
    #
    #   => orc = Monster.new('orc')
    def initialize(monster_type)
      @monster_type = MonsterType.new(monster_type)
    end

    def deep_clone
      Monster.new(@monster_type)
    end

    # Delegates getting monster health to the monster_type
    #
    # Examples
    #
    #   => orc.health
    def health
      @monster_type.health
    end

    # Delegates getting monster attack to the monster_type
    #
    # Examples
    #
    #   => orc.attack
    def attack
      @monster_type.attack
    end

    # Delegates getting monster range to the monster_type
    #
    # Examples
    #
    #   => orc.range
    def range
      @monster_type.range
    end

    # Delegates getting monster resistances to the monster_type
    #
    # Examples
    #
    #   => orc.resistances
    def resistances
      @monster_type.resistances
    end

    # Delegates getting monster weaknesses to the monster_type
    #
    # Examples
    #
    #   => orc.weaknesses
    def weaknesses
      @monster_type.weaknesses
    end

    # Gets this monster's prototype name if it has one and the string 'none' if it does not
    #
    # Examples
    #
    #   => orc_wizard.prototype_name
    def prototype_name
      @monster_type.prototype_name
    end
  end

end