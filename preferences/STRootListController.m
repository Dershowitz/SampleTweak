#include "STRootListController.h"

@implementation STRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {

		// Basically loads the specifiers from a plist file...
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];

	}

	return _specifiers;
}

@end
