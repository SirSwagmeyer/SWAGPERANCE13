/// Charge defines
// Should be set on charge abilities that trigger when a weapon is attacking
#define ABILITY_ON_ATTACK (1<<0)
	// Should be set on charge abilities that trigger on special ATTACK circumstances, it disables ChargeAttack() as a proc
	#define ABILITY_UNIQUE (1<<1)
// Should be set on charge abilities that trigger when using the weapon itself
#define ABILITY_ON_ACTIVATION (1<<2)
