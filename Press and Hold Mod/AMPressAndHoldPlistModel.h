//  AMPressAndHoldPlistModel.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Foundation/Foundation.h>
#import "AMLocaleUtility.h"

static NSString *const BASEPATH = @"/System/Library/Input Methods/PressAndHold.app/Contents/Resources/";

@interface AMPressAndHoldPlistModel : NSObject

@property NSMutableDictionary *plistFiles;

- (NSArray *) sortedLanguageList;
- (NSString *) readPlistFileContentsForKey: (NSString *) key;

@end
