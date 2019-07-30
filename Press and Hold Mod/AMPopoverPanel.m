//  AMPopover.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPopoverPanel.h"

@implementation AMPopoverPanel

const NSRectEdge AMNoEdge = CGRectMaxYEdge + 1;

#pragma mark NSWindow methods
- (instancetype) initWithContentRect:(NSRect)contentRect //might be redundant
						   styleMask:(NSWindowStyleMask)aStyle
							 backing:(NSBackingStoreType)bufferingType
							   defer:(BOOL)flag {
	if (self = [super initWithContentRect:contentRect
								styleMask:aStyle
								  backing:bufferingType
									defer:flag]) {
		[self setOpaque: NO];
		[self setHasShadow: YES];
		[self setBackgroundColor: [NSColor clearColor]];
		
		//[self setBackgroundColor: [NSColor greenColor]];
	}
	return self;
}

- (BOOL) canBecomeKeyWindow { return YES; }

//#warning temp
//- (void) orderWindow:(NSWindowOrderingMode)place
//		  relativeTo:(NSInteger)otherWin {
//	if (!self.contentView) self.contentView = [[AMPopoverView alloc] init]; //lazy init the content view if needed
//	[super orderWindow: place relativeTo: otherWin];
//}

#pragma mark NSResponder methods
- (void)cancelOperation:(id)sender {
	if ([self.delegate respondsToSelector:@selector(windowShouldClose:)] &&
		[self.delegate windowShouldClose:self]) [self close];
}

#pragma mark other methods

@end
