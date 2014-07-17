//
//  AMKeyboardView.m
//  Press and Hold Mod
//
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.
//

#import "AMKeyboardView.h"

@implementation AMKeyboardView

- (void) awakeFromNib {
	[self becomeFirstResponder];
}

- (void) keyDown:(NSEvent *)event {
    DLog(@"");
	NSLog(@"Chars: %@ KeyCode: %hu", [event characters], [event keyCode]);
	NSButton *button = (NSButton *) [self viewWithTag:[event keyCode]];
	if (button != nil /*&& button.state == NSOffState*/) {
		[button performClick:button];
		//[button performSelector:@selector(performClick:) withObject:event afterDelay:0.5];
	}
}
@end
