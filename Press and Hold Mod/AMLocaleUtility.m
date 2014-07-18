//  AMLocaleUtility.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMLocaleUtility.h"

@implementation AMLocaleUtility

+ (NSString *) localeCodeToString: (NSString *) localeCode {
	return [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:localeCode];
}


+ (NSString *) userLanguagePreference {
	NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
	NSString *primaryLanguage = [languages objectAtIndex:0];
	return [self localeCodeToString: primaryLanguage];
}

+ (NSString *) userInputSourcePreference {
	NSString *userInputSource = [[NSLocale currentLocale] localeIdentifier];
	return [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:userInputSource];
}

@end
