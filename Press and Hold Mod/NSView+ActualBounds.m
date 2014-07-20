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
	return NSMakeRect(r.origin.x + self.alignmentRectInsets.left,
					  r.origin.y + self.alignmentRectInsets.bottom,
					  r.size.width - self.alignmentRectInsets.left - self.alignmentRectInsets.right,
					  r.size.height - self.alignmentRectInsets.bottom - self.alignmentRectInsets.top);
}

@end
