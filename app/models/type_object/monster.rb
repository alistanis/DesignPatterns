module Patterns

  # Monster -> Object
  #
  # The monster class. It delegates its calls to the monster type class.
  # This is an example of the Type Object pattern.
  class Monster

    # Initializes the monster class
    #
    # Examples
    #
    #   => orc = Monster.new('orc')
    def initialize(monster_type)
      @monster_type = MonsterType.new(monster_type)
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
  end

end