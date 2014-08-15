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
		
		//[self setBackgroundColor:[NSColor greenColor]];
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
	newBorderWidth *= 2; //border is originally centered on the edge, so half is hidden.
	frame.size.height += newBorderWidth; //adjusts for thickeness of border
	frame.size.width += newBorderWidth;
	NSRect newContentRect = frame;
	newContentRect.origin = NSZeroPoint;
	switch (self.arrowEdge = newArrowEdge) {
		case NSMaxYEdge: //Up Arrow
			if (newArrowPosition == -1) newArrowPosition = frame.size.width/2;
			frame.size.height += newArrowSize.height; //makes room for the arrow
			frame.origin.y -= frame.size.height; //shifts the frame below the desired point
			frame.origin.x -= newArrowPosition; //shifts horizontally so the arrow lines up with the desired point
			break;
			
		case NSMinYEdge: //Down Arrow
			if (newArrowPosition == -1) newArrowPosition = frame.size.width/2;
			newContentRect.origin.y += newArrowSize.height; //shifts the contentRect above the desired point
			
			frame.size.height += newArrowSize.height; //makes room for the arrow
			frame.origin.x -= newArrowPosition; //shifts horizontally so the arrow lines up with the desired point
			break;
			
		case NSMaxXEdge: //Right Arrow
			if (newArrowPosition == -1) newArrowPosition = frame.size.height/2;
			frame.size.width += newArrowSize.height;  //makes room for the arrow
			frame.origin.x -= frame.size.width; //shifts the frame to the left of the desired point
			frame.origin.y -= newArrowPosition; //shifts vertically so the arrow lines up with the desired point
			break;
			
		case NSMinXEdge: //Left Arrow
			if (newArrowPosition == -1) newArrowPosition = frame.size.height/2;
			newContentRect.origin.x += newArrowSize.height; //shifts the contentRect to the right of the desired point
			
			frame.size.width += newArrowSize.height;  //makes room for the arrow
			frame.origin.y -= newArrowPosition; //shifts vertically so the arrow lines up with the desired point
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
