#include "ruby.h"

typedef struct {
    int health;
    int attack;
    int attack_range;
    char **resistances;
    char **weaknesses;
    char *name;
    char *prototype_name;
} monster_type;