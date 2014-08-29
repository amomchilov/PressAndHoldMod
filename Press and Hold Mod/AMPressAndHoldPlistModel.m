//  AMPressAndHoldPlistModel.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPressAndHoldPlistModel.h"

@implementation AMPressAndHoldPlistModel

- (instancetype) init {
	if (self = [super init]) {
		_plistFiles = [[NSMutableDictionary alloc] init];
		
		NSFileManager *fileManager = [NSFileManager defaultManager];
		NSPredicate *plistPredicate = [NSPredicate predicateWithFormat:@"SELF like %@", @"Keyboard*.plist"];
		NSArray *plistFileNames = [[fileManager contentsOfDirectoryAtPath:BASEPATH error:nil]
								   filteredArrayUsingPredicate: plistPredicate];
		
		for (NSString *plistFileName in plistFileNames) {
			NSString *plistFileLocaleCode = [plistFileName substringWithRange: NSMakeRange(9, plistFileName.length - 9 - 6)];
			NSString *localeName = [AMLocaleUtilities localeCodeToString: plistFileLocaleCode];
			NSString *plistFilePath = [NSString stringWithFormat:@"%@%@", BASEPATH, plistFileName];
			if (localeName)
				[_plistFiles setObject: plistFilePath forKey:localeName];
//			else if ([plistFileLocaleCode isEqual: @"default"])
//				[_plistFiles setObject:plistFilePath forKey:@"Default"];
		}
	}
	return self;
}

- (NSArray *) sortedLanguageList {
	return [[_plistFiles allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSString *) fileContentsForPlistKey: (NSString *) key {
	self.activePlistFilePath = [_plistFiles objectForKey:key];
	
	//set the text view to a dictionary with the contents of the plist
	return [NSString stringWithContentsOfFile: self.activePlistFilePath
									 encoding: NSUTF8StringEncoding
										error: nil];
}

- (NSArray *) stringArrayForPlistKey: (NSString *) plistKey
						CharacterKey: (NSString *) characterKey {
	NSString *plistPath = [_plistFiles objectForKey: plistKey];
	NSDictionary *plistContents = [NSDictionary dictionaryWithContentsOfFile: plistPath];
	
	NSString *fullCharacterKey = [[NSString alloc] initWithFormat:@"Roman-Accent-%@", characterKey];
	NSDictionary *characterDict = [plistContents objectForKey: fullCharacterKey];
	if (characterDict) {
		NSString *keycaps = [characterDict objectForKey: @"Keycaps"];
		NSArray *keycapsArray = [keycaps componentsSeparatedByString: @" "];
		NSRange range = NSMakeRange(1, keycapsArray.count - 1); //to strip the first character
		return [keycapsArray subarrayWithRange: range];
	}
	return nil;
}

@end
