//  AMPopover.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPopoverPanel.h"

@implementation AMPopoverPanel

#pragma mark NSWindow methods
- (instancetype) initWithContentRect:(NSRect)contentRect //might be redundant
						   styleMask:(NSUInteger)aStyle
							 backing:(NSBackingStoreType)bufferingType
							   defer:(BOOL)flag {
	if (self = [super initWithContentRect:contentRect
								styleMask:aStyle
								  backing:bufferingType
									defer:flag]) {
		[self setOpaque:NO];
		[self setBackgroundColor:[NSColor clearColor]];
		
		[self setBackgroundColor:[NSColor greenColor]];
	}
	return self;
}

- (BOOL) canBecomeKeyWindow { return YES; }

#pragma mark NSResponder methods
- (void)cancelOperation:(id)sender {
	if ([self.delegate respondsToSelector:@selector(windowShouldClose:)]
		&& [self.delegate windowShouldClose:self]) [self close];
}

#pragma mark other methods

- (void) popoverWithFrame:(NSRect) frame
		  backgroundColor:(NSColor *) newViewBackgroundColor
			  borderColor:(NSColor *) newBorderColor
			  borderWidth:(int) newBorderWidth
			 cornerRadius:(float) newCornerRadius
				arrowSize:(NSSize) newArrowSize
				arrowEdge:(NSRectEdge) newArrowEdge
			arrowPosition:(float) newArrowPosition {
//	newArrowPosition = 10;
	newArrowEdge = NSMaxXEdge;
	
	NSRect newContentRect = frame;
	newContentRect.origin = NSZeroPoint;
	switch (self.arrowEdge = newArrowEdge) {
		case NSMaxYEdge: //Up Arrow
			if (newArrowPosition == -1) newArrowPosition = frame.size.width/2;
			//temp.size.height = frame.size.height;
			frame.size.height += newArrowSize.height;
			frame.origin.y -= frame.size.height;
			frame.origin.x -= newArrowPosition;
			
			break;
			
		case NSMinYEdge: //Down Arrow
			if (newArrowPosition == -1) newArrowPosition = frame.size.width/2;
			//temp.size.height = frame.size.height;
			newContentRect.origin.y += newArrowSize.height;
			
			frame.size.height += newArrowSize.height;
			frame.origin.x -= newArrowPosition;
			break;
			
		case NSMaxXEdge: //Right Arrow
			if (newArrowPosition == -1) newArrowPosition = frame.size.height/2;
			frame.size.width += newArrowSize.height;
			frame.origin.x -= frame.size.width;
			frame.origin.y -= newArrowPosition;
			break;
			
		case NSMinXEdge: //Left Arrow
			if (newArrowPosition == -1) newArrowPosition = frame.size.height/2;
			newContentRect.origin.x += newArrowSize.height;
			
			frame.size.width += newArrowSize.height;
			frame.origin.y -= newArrowPosition;
			break;
	}
	
	self.contentRect = newContentRect;
	self.viewBackgroundColor = newViewBackgroundColor;
	self.borderColor = newBorderColor;
	self.borderWidth = newBorderWidth;
	self.cornerRadius = newCornerRadius;
	self.arrowSize = newArrowSize;
	self.arrowPosition = newArrowPosition;
	
	[super setFrame: frame display: YES];
}

@end
