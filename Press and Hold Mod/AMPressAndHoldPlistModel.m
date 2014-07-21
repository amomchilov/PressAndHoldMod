//  AMPressAndHoldPlistModel.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPressAndHoldPlistModel.h"

@implementation AMPressAndHoldPlistModel

- (id) init {
	if (self = [super init]) {
		self.plistFiles = [[NSMutableDictionary alloc] init];
		
		NSFileManager *fileManager = [NSFileManager defaultManager];
		NSPredicate *plistPredicate = [NSPredicate predicateWithFormat:@"SELF like %@", @"Keyboard*.plist"];
		NSArray *plistFileNames = [[fileManager contentsOfDirectoryAtPath:BASEPATH error:nil]
								   filteredArrayUsingPredicate: plistPredicate];
		
		for (NSString *plistFileName in plistFileNames) {
			NSString *plistFileLocaleCode = [plistFileName substringWithRange: NSMakeRange(9, plistFileName.length - 9 - 6)];
			NSString *localeName = [AMLocaleUtility localeCodeToString: plistFileLocaleCode];
			NSString *plistFilePath = [NSString stringWithFormat:@"%@%@", BASEPATH, plistFileName];
			if (localeName)
				[self.plistFiles setObject: plistFilePath forKey:localeName];
			else if ([plistFileLocaleCode isEqual: @"default"])
				[self.plistFiles setObject:plistFilePath forKey:@"Default"];
		}
		NSLog(@"%@", self.plistFiles);
	}
	return self;
}

- (NSArray *) sortedLanguageList {
	return [[self.plistFiles allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSString *) plistFileContentsForKey: (NSString *) key {
	NSString *plistPath = [self.plistFiles objectForKey:key];
	
	//set the text view to a dictionary with the contents of the plist
	return [NSString stringWithContentsOfFile:plistPath
							encoding:NSUTF8StringEncoding
							error:nil];
}

- (NSArray *) arrayOfStringsForCharacterKey: (NSString *) CharacterKey forPlistKey: (NSString *) plistKey {
#warning TODO: implement this
	return @[];
}

@end
