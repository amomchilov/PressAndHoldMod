//  AMKeyboardModel.m
//  Created by Alexander Momchilov on 2014-07-27.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMKeyboardModel.h"
#define N_ELEMENTS(X)           (sizeof(X)/sizeof(*(X)))

const unsigned short AMCharacterKeyCodes[] =
{0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
11, 12, 13, 14, 15, 16, 17, 18, 19,
20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
30, 31, 32, 33, 34, 35, 37, 38, 39,
40, 41, 42, 43, 44, 45, 46, 47, 50};
const size_t AMCharacterKeyCodes_Size = N_ELEMENTS(AMCharacterKeyCodes);

const unsigned short AMModifierKeyCodes[] = {56, 63, 59, 58, 55, 60, 62, 61, 54};
const size_t AMModifierKeyCodes_Size = N_ELEMENTS(AMModifierKeyCodes );

const NSUInteger AMKeyMasks[] = {
	NSShiftKeyMask,
	NSFunctionKeyMask,
	NSControlKeyMask,
	NSAlternateKeyMask,
	NSCommandKeyMask,
	NSShiftKeyMask,
	NSControlKeyMask,
	NSAlternateKeyMask,
	NSCommandKeyMask
};

@implementation AMKeyboardModel

- (instancetype) init {
	if (self = [super init]) {
		[self rebuildKeyLayout];
	}
	return self;
}

- (void) rebuildKeyLayout {
	NSMutableDictionary *keyLayoutNoModifier = [[NSMutableDictionary alloc] init];
	NSMutableDictionary *keyLayoutShift = [[NSMutableDictionary alloc] init];
	NSMutableDictionary *keyLayoutOption = [[NSMutableDictionary alloc] init];
	NSMutableDictionary *keyLayoutShiftOption = [[NSMutableDictionary alloc] init];

	for (int i = 0; i < AMCharacterKeyCodes_Size; i++) {
		unsigned short keycode = AMCharacterKeyCodes[i];
		NSNumber *key = [NSNumber numberWithInt: AMCharacterKeyCodes[i]];
		[keyLayoutNoModifier setObject: [AMLocaleUtilities stringForKeyCode: keycode
													   WithModifiers: 0]
								forKey: key];

		[keyLayoutShift setObject: [AMLocaleUtilities stringForKeyCode: keycode
												  WithModifiers: NSShiftKeyMask]
						   forKey: key];

		[keyLayoutOption setObject: [AMLocaleUtilities stringForKeyCode: keycode
												   WithModifiers: NSAlternateKeyMask]
							forKey: key];

		[keyLayoutShiftOption setObject: [AMLocaleUtilities stringForKeyCode:
										  keycode WithModifiers: NSShiftKeyMask | NSAlternateKeyMask]
								 forKey: key];
	}
	self.keyLayouts = @{@(0) : keyLayoutNoModifier,
						@(NSShiftKeyMask) : keyLayoutShift,
						@(NSAlternateKeyMask) : keyLayoutOption,
						@(NSShiftKeyMask | NSAlternateKeyMask) : keyLayoutShiftOption};
						
}

- (NSString *) stringForKeyCode:(unsigned short) keycode
		   WithNSEventModifiers:(unsigned int) modifiers {
	NSNumber *maskedModifiers = @(modifiers & (NSShiftKeyMask | NSAlternateKeyMask));
	return [[self.keyLayouts objectForKey: maskedModifiers] objectForKey: @(keycode)];
}

#pragma mark utility Class methods

+ (BOOL) isModifier:(unsigned short) keycode {
	for (int i = 0; i < AMModifierKeyCodes_Size; i++) {
		if (keycode == AMModifierKeyCodes[i]) return true;
	}
	return false;
}

@end
