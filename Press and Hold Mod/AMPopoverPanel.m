//  AMPopover.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPopoverPanel.h"

@implementation AMPopoverPanel

#pragma mark NSWindow methods
- (instancetype) initWithContentRect:(NSRect)contentRect
						   styleMask:(NSUInteger)aStyle
							 backing:(NSBackingStoreType)bufferingType
							   defer:(BOOL)flag {
	if (self = [super initWithContentRect:contentRect
								styleMask:aStyle
								  backing:bufferingType
									defer:flag]) {
		_padding = 6;
		_borderWidth = 1;
		_arrowEdge = NSMinYEdge;
		[self setOpaque:NO];
		[self setBackgroundColor:[NSColor clearColor]];
		//[self setBackgroundColor:[NSColor greenColor]];
	}
	return self;
}

- (void) setContentView:(NSView *)contentView {
	[super setContentView: contentView];
	if (![contentView isKindOfClass: [AMPopoverView class]]) return;
	AMPopoverView *view = (AMPopoverView *) contentView;
	view.backgroundColor = [NSColor whiteColor];
	view.borderColor = [NSColor colorWithCalibratedRedHex: 0xC2
												 greenHex: 0xD7
												  blueHex: 0xFE
												 alphaHex: 0xFF];
	view.borderWidth = _borderWidth;
	view.cornerRadius = 4;
	view.arrowSize = NSMakeSize(9, _padding);
	view.arrowEdge = _arrowEdge;
}

- (BOOL) canBecomeKeyWindow { return YES; }

- (void) setFrame:(NSRect)frameRect display:(BOOL)flag {
	int insetWidth = -(_padding + _borderWidth); //negative inset is a psuedo outset
	frameRect = NSInsetRect(frameRect, insetWidth, insetWidth);
	switch (_arrowEdge) {
		case NSMaxXEdge: frameRect.origin.x -= _padding; break;
		case NSMinXEdge: frameRect.origin.x += _padding; break;
		case NSMaxYEdge: frameRect.origin.y -= _padding; break;
		case NSMinYEdge: frameRect.origin.y += _padding; break;
	}
	
	[super setFrame:frameRect display:flag];
}

#pragma mark NSResponder methods
- (void)cancelOperation:(id)sender {
	if ([self.delegate respondsToSelector:@selector(windowShouldClose:)]
		&& [self.delegate windowShouldClose:self]) [self close];
}

@end
