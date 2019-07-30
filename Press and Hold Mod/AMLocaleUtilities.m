//  AMLocaleUtility.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMLocaleUtilities.h"

@implementation AMLocaleUtilities

+ (NSString *) localeCodeToString: (NSString *) localeCode {
	return [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:localeCode];
}

+ (NSArray *) localeCodesToStrings: (NSArray *) localeCodes {
	NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity: localeCodes.count];
	for (NSString *s in localeCodes) {
		[result addObject: [self localeCodeToString: s]];
	}
	return result;
}

//+ (NSString *) userLanguagePreference {
//	NSString *userInputSource = [[NSLocale currentLocale] localeIdentifier];
//	return [[NSLocale currentLocale] displayNameForKey: NSLocaleIdentifier value: userInputSource];
//}

+ (NSArray *) userLanguagePreferences {
	return [self localeCodesToStrings: [NSLocale preferredLanguages]];
}

+ (unsigned int) convertCocoaFlagsToCarbonForFlags:(NSEventModifierFlags) eventModifierFlags {
	unsigned int result = 0;
	if (eventModifierFlags & NSShiftKeyMask) result |= shiftKey;
	if (eventModifierFlags & NSControlKeyMask) result |= controlKey;
	if (eventModifierFlags & NSAlternateKeyMask) result |= optionKey;
	if (eventModifierFlags & NSCommandKeyMask) result |= cmdKey;
	return result;
}

/** magical code based off of shortcutrecorder */
+ (NSString *) stringForKeyCode:(int) keycode
				  WithModifiers:(NSEventModifierFlags) modifiers {
	if (keycode < 0) return nil;
	TISInputSourceRef tisSource = TISCopyCurrentKeyboardInputSource();
	if (!tisSource) return nil;

	CFDataRef layoutData = (CFDataRef)TISGetInputSourceProperty(tisSource, kTISPropertyUnicodeKeyLayoutData);
	
	CFRelease(tisSource);
	
	// For non-unicode layouts such as Chinese, Japanese, and Korean, get the ASCII capable layout
	if(!layoutData) {
		tisSource = TISCopyCurrentASCIICapableKeyboardLayoutInputSource();
		layoutData = (CFDataRef)TISGetInputSourceProperty(tisSource, kTISPropertyUnicodeKeyLayoutData);
		CFRelease(tisSource);
	}
	
	if (!layoutData) return nil;
	
	const UCKeyboardLayout *keyLayout = (const UCKeyboardLayout *)CFDataGetBytePtr(layoutData);
	unsigned int carbonModifierFlags = ([self convertCocoaFlagsToCarbonForFlags: modifiers] >> 8) & 0xFF;
	UInt32 keysDown = 0;
	UniCharCount length = 4, realLength;
	UniChar chars[4];
	OSStatus err = UCKeyTranslate(keyLayout,
								  keycode,
								  kUCKeyActionDisplay,
								  carbonModifierFlags,
								  LMGetKbdType(),
								  kUCKeyTranslateNoDeadKeysBit,
								  &keysDown,
								  length,
								  &realLength,
								  chars);
	
	if (err) return nil;
	return [NSString stringWithCharacters:chars length:1];
}

+ (BOOL) isCharacterForKeycode: (int) keycode {
	if (0 <= keycode && keycode <= 50
		&& keycode != 10
		&& keycode != 36
		&& keycode != 48
		&& keycode != 49) return YES;
	return NO;
}

#warning move above method.

@end
