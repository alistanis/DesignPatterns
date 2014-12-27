#include "monster_types.h"

struct *monster_type return_monster_type(int health, int attack, int attack_range, char **resistances, char **weaknesses, char *name, char *prototype_name)
{
    struct monster_type *mon_type;
    mon_type->health = health;
    mon_type->attack = attack;
    mon_type->attack_range = attack_range;
    mon_type->resistances = resistances;
    mon_type->weaknesses = weaknesses;
    mon_type->name = name;
    mon_type->prototype_name = prototype_name;

    return mon_type;
}