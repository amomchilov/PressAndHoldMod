//  AMLocaleUtility.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>

/**
 @brief  This class contains various class methods for working with locale codes and language keys.
 */
@interface AMLocaleUtilities : NSObject
//TODO:  expand to check for other keys

/**
 @brief  Converts an locale code to a localized string in the user's current language

 @discussion Example:
	NSLocale *french = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
	NSString *frenchName = [french displayNameForKey:NSLocaleIdentifier value:@"fr_FR"];

	NSLocale *english = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
	NSString *englishName = [english  displayNameForKey:NSLocaleIdentifier value:@"fr_FR"];

	NSLog(@"French locale in French is called '%@'", frenchName);
	//prints "French locale in French is called 'français (France)'"
	NSLog(@"French locale in English is called '%@'", englishName);
	//prints "French locale in English is called 'French (France)'"

 @param localeCode The localeCode to be converted.

 @return A localized string in the user's current language
 */
+ (NSString *) localeCodeToString: (NSString *) localeCode;

/**
 @brief Iterates through the given array of NSStrings, and converting them with localeCodeToString:.

 @param localeCodes An array of NSStrings to be converted.

 @return The converted array of NSStrings

 @see localeCodeToString:
 */
+ (NSArray *) localeCodesToStrings: (NSArray *) localeCodes;

//+ (NSString *) userLanguagePreference;

/**
 @brief  Produces an NSArray of NSStrings of localized names of the "Prefered languages" under the "Language and Region" preference pane.

 @return an NSArray of NSStrings of localized names of the "Prefered languages" under the "Language and Region" preference pane.
 */
+ (NSArray *) userLanguagePreferences;

/**
 @brief Converts Cocoa style modifer flags (such as in NSEvent), to those used by the "Text Input Source Service" of the Carbon Framework

 @param eventModifierFlags Cocoa style modifer flags to be converted

 @return "Text Input Source Service" style modfier flags for the given parameters
 */
+ (int) convertCocoaFlagsToCarbonForFlags:(int) eventModifierFlags;

/**
 @brief Gets the key label for the specified keycode and modifiers (Cocoa/NSEvent style), for the user's current input source/

 @param keycode   The keycode of the desired key label
 @param modifiers The modifiers applied for the desired key label (Cocoa/NSEvent style)

 @return An NSString instance containing the desired key label.
 
 @warning Can return nil for invalid combinations of keycode/modifiers.
 */
+ (NSString *) stringForKeyCode: (int)keycode WithNSEventModifiers:(int)modifiers;

/**
 @brief Checks wether a given keycode is a character key.

 @discussion Character keys on a typical English keyboard are:
 
	` 1 2 3 4 5 6 7 8 9 0 - =
	 q w e r t y u i o p [ ] \
	  a s d f g h j k l ; '
	   z x c v b n m , . /

 @param keycode The keycode to be checked.

 @return YES if the keycode is a character, otherwise NO.
 */
+ (BOOL) isCharacterForKeycode: (int) keycode;

@end
