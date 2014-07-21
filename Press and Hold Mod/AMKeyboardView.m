//  AMKeyboardView.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMKeyboardView.h"

@implementation AMKeyboardView

- (void)awakeFromNib {
    [super awakeFromNib];
	[self becomeFirstResponder];
}

- (BOOL)acceptsFirstResponder {
    [super acceptsFirstResponder];
    return YES;
}

- (void)keyDown:(NSEvent *)event {
	[self.delegate keyboard: self keyDown: event];
}

@end
