//  AMLocaleUtility.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>

@interface AMLocaleUtilities : NSObject

+ (NSString *) localeCodeToString: (NSString *) localeCode;
+ (NSArray *) localeCodesToStrings: (NSArray *) localeCodes;
+ (NSString *) userLanguagePreference;
+ (NSArray *) userInputSourcePreferences;
+ (NSString *) stringForKeyCode: (int)keycode;
+ (BOOL) isCharacterForKeycode: (int) keycode;

@end
