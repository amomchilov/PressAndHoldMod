//  AMKeyboardView.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMKeyboardView.h"

@implementation AMKeyboardView

- (void)awakeFromNib {
    self.allowResignFirstResponder = NO;
}

- (BOOL)acceptsFirstResponder {
    //[super acceptsFirstResponder];
    return YES;
}

- (void)keyDown:(NSEvent *)event {
	[self.delegate keyboard: self keyDown: event];
}

- (BOOL) resignFirstResponder {
	if (!self.allowResignFirstResponder)
		[NSTimer scheduledTimerWithTimeInterval: 1 target: self selector:@selector(allowKeyboardResignFirstResponse) userInfo:nil repeats:NO];
	return self.allowResignFirstResponder;
}

- (void)allowKeyboardResignFirstResponse {
	self.allowResignFirstResponder = YES;
}
@end
