require 'json'

module Patterns

  # The default monster json data path
  MONSTER_JSON_PATH = File.dirname(__FILE__) + '/monster_types'

  # MonsterType -> Object
  #
  # A type object that uses prototype data for a monster if it exists, or uses the base data if it doesn't.
  # This makes creating new types of monsters very easy and means that this data doesn't have a reliance on code.
  # If we built a monster generator, we could simply save all the monster data as json and be able to declare them immediately.
  class MonsterType

    # The name of the monster
    attr_accessor :name
    # The health of the monster
    attr_accessor :health
    # The attack power of the monster
    attr_accessor :attack
    # A list of the monster's resistances
    attr_accessor :resistances
    # A list of the monster's weaknesses
    attr_accessor :weaknesses
    # The attack range of the monster
    attr_accessor :range
    # The name of the prototype monster if it exists, or none if it does not
    attr_accessor :prototype_name

    # Initializes the monster type object. If the monster has a prototype, it collects and sets the prototype data first.
    # Then the initializer sets the base type data. The base type will always override the prototype if the base type has differing data.
    # In a real implementation, it would likely be beneficial to allow for multiple prototypes or prototype inheritance.
    # That solution would be recursive and would set all data from the lowest prototype back up to the base type.
    #
    # * +monster_type+ - The type of the monster that has a corresponding json file as a String, or a MonsterType Object
    #
    # Examples
    #
    #   => monster_type = MonsterType.new('dragon')
    def initialize(monster_type)
      @type_data = {}

      if monster_type.is_a?(String)
        @monster_type = monster_type
        @type_data = populate_type_data(@monster_type)
        if has_prototype?
          populate_prototype_data
          @health = @prototype_data['health']
          @attack = @prototype_data['attack']
          @range = @prototype_data['attack_range']
          @resistances = @prototype_data['resistances']
          @weaknesses = @prototype_data['weaknesses']
        end
      elsif monster_type.is_a?(MonsterType)
        @type_data = monster_type.to_h
      else
        raise UnsupportedType, 'Type must be either MonsterType or String'
      end

      if @type_data['health'] != nil
        @health = @type_data['health']
      end
      if @type_data['attack'] != nil
        @attack = @type_data['attack']
      end
      if @type_data['range'] != nil
        @range = @type_data['range']
      end
      if @type_data['resistances'] != nil
        @resistances = @type_data['resistances']
      end
      if @type_data['weaknesses'] != nil
        @weaknesses = @type_data['weaknesses']
      end
      @name = @type_data['name']
    end

    # Populates type data based on monster name
    #
    #
    # * +monster_type+ - The type of the monster that has a corresponding json file
    #
    # Examples
    #
    #   => populate_type_data('orc')
    def populate_type_data(monster_type)
      json_file_name = monster_type + '.json'
      json_file_path = MONSTER_JSON_PATH + '/' + json_file_name
      if File.exist?(json_file_path)
        type_data = File.read(json_file_path)
        JSON.parse(type_data)
      else
        raise MonsterNotFound, 'Monster type does not exist'
      end
    end

    # Populates prototype data
    #
    # Examples
    #
    #   => populate_prototype_data
    def populate_prototype_data
      @prototype_data = populate_type_data(@type_data['prototype_name'])
    end

    # Returns the prototype name if it has one, returns 'none' otherwise
    #
    # Examples
    #
    #   => prototype_name
    def prototype_name
      if has_prototype?
        @prototype_data['name']
      else
        'none'
      end
    end

    # Returns true of false if the type has a prototype
    #
    # Examples
    #
    #   => if has_prototype?
    #   =>  @prototype_data = populate_type_data
    #   => end
    def has_prototype?
      @type_data['prototype']
    end
  end

  def to_h
    {'name' => @name, 'health' => @health, 'attack' => @attack, 'attack_range' => @range, 'resistances' => @resistances, 'weaknesses' => @weaknesses, 'prototype' => @prototype}
  end


  # MonsterNotFound -> StandardError
  #
  # Raises a MonsterNotFound exception when the monster json file doesn't exist
  class MonsterNotFound < StandardError
  end

  # UnsupportedType -> StandardError
  #
  # Raises an UnsupportedType exception when the argument passed in is not a String, Hash, or MonsterType
  class UnsupportedType < StandardError
  end
end