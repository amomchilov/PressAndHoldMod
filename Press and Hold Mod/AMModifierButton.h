//
//  AMModifierButton.h
//  Press and Hold Mod
//
//  Created by Alexander Momchilov on 2014-08-03.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AMModifierButton : NSButton

@property BOOL mouseEnabled;

- (void) setMouseEnabledAndState:(BOOL) state;

@end
