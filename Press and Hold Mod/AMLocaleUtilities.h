//  AMLocaleUtility.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>

@interface AMLocaleUtilities : NSObject

+ (NSString *) localeCodeToString: (NSString *) localeCode;
+ (NSString *) userLanguagePreference;
+ (NSString *) userInputSourcePreference;
+ (NSString *) stringForKeyCode: (int)keycode;
@end
