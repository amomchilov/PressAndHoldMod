//  AMPopover.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "AMPopoverView.h"

@interface AMPopoverPanel : NSPanel

@property NSRect contentRect;
@property NSColor *viewBackgroundColor;
@property NSColor *borderColor;
@property int borderWidth;
@property float cornerRadius;
@property NSSize arrowSize;
@property NSRectEdge arrowEdge;
@property CGFloat arrowPosition;

@property (weak) IBOutlet NSTextField *label;

- (void) popoverWithFrame:(NSRect) frame
		  backgroundColor:(NSColor *) newViewBackgroundColor
			  borderColor:(NSColor *) newBorderColor
			  borderWidth:(int) newBorderWidth
			 cornerRadius:(float) newCornerRadius
				arrowSize:(NSSize) newArrowSize
				arrowEdge:(NSRectEdge) newArrowEdge
			arrowPosition:(float) newArrowPosition;
@end