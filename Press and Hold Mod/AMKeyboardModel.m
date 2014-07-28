//  AMKeyboardModel.m
//  Created by Alexander Momchilov on 2014-07-27.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMKeyboardModel.h"

const int keyCodes[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
	11, 12, 13, 14, 15, 16, 17, 18, 19,
	20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
	30, 31, 32, 33, 34, 35, 37, 38, 39,
	40, 41, 42, 43, 44, 45, 46, 47, 50};

@implementation AMKeyboardModel

- (id) init {
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
	
	for (int i = 0; i < sizeof(keyCodes)/sizeof(keyCodes[0]); i++) {
		int keycode = keyCodes[i];
		NSNumber *key = [NSNumber numberWithInt: keyCodes[i]];
		[keyLayoutNoModifier setObject: [AMLocaleUtilities stringForKeyCode: keycode WithNSEventModifiers: 0] forKey: key];
		[keyLayoutShift setObject: [AMLocaleUtilities stringForKeyCode: keycode WithNSEventModifiers: NSShiftKeyMask] forKey: key];
		[keyLayoutOption setObject: [AMLocaleUtilities stringForKeyCode: keycode WithNSEventModifiers: NSAlternateKeyMask] forKey: key];
		[keyLayoutShiftOption setObject: [AMLocaleUtilities stringForKeyCode: keycode WithNSEventModifiers: NSShiftKeyMask | NSAlternateKeyMask] forKey: key];
	}
	self.keyLayouts = @{@(0) : keyLayoutNoModifier,
						@(NSShiftKeyMask) : keyLayoutShift,
						@(NSAlternateKeyMask) : keyLayoutOption,
						@(NSShiftKeyMask | NSAlternateKeyMask) : keyLayoutShiftOption};
						
}

- (NSString *) stringForKeyCode: (int) keycode WithNSEventModifiers: (int) modifiers {
	NSNumber *maskedModifiers = @(modifiers & (NSShiftKeyMask | NSAlternateKeyMask));
	return [[self.keyLayouts objectForKey: maskedModifiers] objectForKey: @(keycode)];
}

@end
