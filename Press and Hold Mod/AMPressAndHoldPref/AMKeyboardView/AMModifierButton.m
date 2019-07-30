//  AMModifierButton.m
//  Created by Alexander Momchilov on 2014-08-03.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMModifierButton.h"

@implementation AMModifierButton

- (instancetype) initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder: coder]) {
		_mouseEnabled = YES;
    }
    return self;
}

- (void)mouseDown:(NSEvent*)event{
	if (_mouseEnabled) [super mouseDown:event];
}

- (void) setMouseEnabledAndState:(BOOL) state {
	[self setState: state ? NSOnState : NSOffState];
	_mouseEnabled = !state;
}

- (BOOL) isPressed {
	return self.state == NSOffState;
}

@end
