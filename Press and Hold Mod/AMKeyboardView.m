//  AMKeyboardView.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMKeyboardView.h"

@implementation AMKeyboardView

#pragma mark NSView methods
- (void)awakeFromNib {
	for (NSView *v in self.subviews) {
		if ([v isKindOfClass:[NSButton class]]) {
			NSButton *b = (NSButton *) v;
			b.target = self;
            b.action = @selector(virtualKeyDown:);
		}
	}
	[self.delegate keyboard: self updateKeyTitlesWithModifiers: 0];
	DLog(@"%@", self);
}

#pragma mark NSResponder methods
- (BOOL)acceptsFirstResponder { return YES; }

- (void)keyDown:(NSEvent *)event {
	[self.delegate keyboard: self keyDown: event];
}

- (void) flagsChanged:(NSEvent *)event {
	[self.delegate keyboard: self flagsChanged: event];
}

#pragma mark Other methods
- (void)virtualKeyDown:(NSButton *) sender {
	[self.delegate keyboard: self virtualKeyDownFromButton: sender];
}
@end
