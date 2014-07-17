//
//  AMKeyboardView.m
//  Press and Hold Mod
//
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.
//

#import "AMKeyboardView.h"

@implementation AMKeyboardView

- (id)initWithFrame:(NSRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self becomeFirstResponder];
    }
    DLog(@"self = %@", self);

    return self;
}

//- (void)drawRect:(NSRect)dirtyRect {
//	[super drawRect:dirtyRect];
//	[[NSColor blackColor] set];
//	NSRectFill(dirtyRect);
//}

- (BOOL) acceptsFirstResponder {
    DLog(@"");
	return YES;
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
