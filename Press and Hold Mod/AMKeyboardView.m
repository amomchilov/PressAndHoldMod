//
//  AMKeyboardView.m
//  Press and Hold Mod
//
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.
//

#import "AMKeyboardView.h"

@implementation AMKeyboardView

- (void)awakeFromNib {
	//[self becomeFirstResponder];
}

- (IBAction)virtualKeyPressed:(NSButton *)sender {
	DLog(@"%@", [sender title]);
	[self.delegate keyboard:self didPressKey:sender];
}

- (void)keyDown:(NSEvent *)event {
    DLog(@"");
	NSLog(@"Chars: %@ KeyCode: %hu", [event characters], [event keyCode]);
	NSButton *button = (NSButton *) [self viewWithTag:[event keyCode]];
	if (button) {
		[button performClick:button];
	}
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}
@end
