//  AMLocaleUtility.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMLocaleUtilities.h"

@implementation AMLocaleUtilities

+ (NSString *) localeCodeToString: (NSString *) localeCode {
	return [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:localeCode];
}

+ (NSArray *) localeCodesToStrings: (NSArray *) localeCodes {
	NSMutableArray *result = [[NSMutableArray alloc] init];
	for (NSString *s in localeCodes) {
		[result addObject: [self localeCodeToString: s]];
	}
	return result;
}

+ (NSArray *) userInputSourcePreferences {
	NSArray *localeCodes = [NSLocale preferredLanguages];
	return [self localeCodesToStrings: localeCodes];
}

+ (NSString *) userLanguagePreference {
	NSString *userInputSource = [[NSLocale currentLocale] localeIdentifier];
	return [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:userInputSource];
}

/** magical code based off of shortcutrecorder */
+ (NSString *) stringForKeyCode: (int)keycode {
	if (keycode < 0) return nil;
	TISInputSourceRef tisSource = TISCopyCurrentKeyboardInputSource();
	if (!tisSource) return nil;
	
	UInt32 keysDown = 0;
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
	
	UniCharCount length = 4, realLength;
	UniChar chars[4];
	
	OSStatus err = UCKeyTranslate(keyLayout,
								  keycode,
								  kUCKeyActionDisplay,
								  0,
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
	if (0 <= keycode
		&& keycode <= 50
		&& keycode != 10
		&& keycode != 36
		&& keycode != 48
		&& keycode != 49) return YES;
	return NO;
}

@end
