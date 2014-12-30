module Patterns
  # Contains CONST declarations for illnesses mapped to integers in the style of an Enum
  module Illness
    # No illness
    NONE = 0
    # Patient has a sore throat, can be cured by general practitioner
    SORE_THROAT = 1
    # Patient has cancer, can be cured by oncologist
    CANCER = 2
    # Patient has internal bleeding, can be cured by surgeon
    INTERNAL_BLEEDING = 3
    # Patient has zombie virus, can not be cured by anyone
    ZOMBIE_VIRUS = 4
  end
end