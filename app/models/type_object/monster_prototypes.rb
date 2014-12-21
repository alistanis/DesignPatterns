module Patterns

  # MonsterPrototypes -> Object
  #
  # A true prototype class, this class allows for the copying of a class to quickly create a new one.
  # All monsters are loaded into memory immediately.
  class MonsterPrototypes

    # The Hash of all the prototypes in the monster_types folder
    attr_accessor :prototypes
    # The list of all the monster names in the monster_types foler
    attr_accessor :monster_names

    # Initializes the MonsterPrototypes class
    #
    # Reads all of the json files, strips their names from the directory path, and then creates new monsters for each name found.
    def initialize
      @monster_names = []
      @prototypes = {}
      Dir["#{MONSTER_JSON_PATH}/**/*.json"].each { |f| @monster_names << f.gsub('.json', '').gsub(MONSTER_JSON_PATH + '/', '') }

      @monster_names.each do |name|
        @prototypes[name] = Monster.new(name)
      end
    end

    # Performs a marshalling of the Monster stored in the Prototype array, which is returned as a new Monster to the caller as a clone of the original
    #
    # Examples
    #
    #   => monsters = MonsterPrototypes.new
    #   => dragon = monsters.clone_type('dragon')
    def clone_type(type_name)
      if @prototypes[type_name] != nil
        serialized_object = Marshal.dump(@prototypes[type_name])
        # Just in case someone was able to write some json onto disk and inject something.
        # This won't actually help anything because the type name is still being read from the same source, but it serves as a security example.
        if %w(exec system eval throw puts exit fork syscall %x send `).include? serialized_object
          Monster.new(type_name)
        else
          Marshal.load(serialized_object)
        end
      end
    end

  end

end