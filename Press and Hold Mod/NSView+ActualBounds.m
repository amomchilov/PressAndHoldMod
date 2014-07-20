//
//  NSView+ActualDimensions.m
//  Press and Hold Mod
//
//  Created by Alexander Momchilov on 2014-07-20.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.
//

#import "NSView+ActualBounds.h"

@implementation NSView (ActualBounds)

- (NSRect) actualBounds {
	NSRect r = [self.window convertRectToScreen:[self convertRect:self.bounds toView:nil]];
	NSEdgeInsets insets = self.alignmentRectInsets;
	return NSMakeRect(r.origin.x + insets.left,
					  r.origin.y + insets.bottom,
					  r.size.width - insets.left - insets.right,
					  r.size.height - insets.bottom - insets.top);
}

@end
