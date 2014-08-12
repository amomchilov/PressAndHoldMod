//  AMPopoverView.m
//  Created by Alexander Momchilov on 2014-08-11.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPopoverView.h"

@implementation AMPopoverView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
	//[[NSGraphicsContext currentContext] setShouldAntialias: NO];
	
	NSRect bounds = self.bounds;
	//0.5 more than needed, due to: http://stackoverflow.com/a/8016669/3141234
	//+0.5 same size as original, cleaner edge
	//-0.5 is 2px taller/wider than original
	if ((self.borderWidth % 2) == 1) bounds = NSInsetRect(bounds, -0.5, -0.5);
	DLog(@"%@", NSStringFromRect(bounds));
	//border
	NSBezierPath *path = [self _popoverBezierPathWithRect: bounds];
	[path setLineWidth: self.borderWidth];
	[self.backgroundColor setFill];
	[path fill];
	[self.borderColor setStroke];
	[path stroke];
}

- (NSBezierPath *)_popoverBezierPathWithRect:(NSRect)rect {
	const CGFloat radius = self.cornerRadius;
	const CGFloat arrowWidth = self.arrowSize.width;
	const CGFloat arrowHeight = self.arrowSize.height;
	const CGFloat inset = radius + arrowHeight;
	const NSRect insetRect = NSInsetRect(rect, inset, inset);
	const CGFloat minX = NSMinX(insetRect);
	const CGFloat maxX = NSMaxX(insetRect);
	const CGFloat minY = NSMinY(insetRect);
	const CGFloat maxY = NSMaxY(insetRect);
	NSPoint arrowPoints[3];
	
	NSBezierPath *path = [NSBezierPath bezierPath];
	[path setLineJoinStyle:NSRoundLineJoinStyle];
	
	//Bottom left corner
	[path appendBezierPathWithArcWithCenter:NSMakePoint(minX, minY) radius:radius startAngle:180 endAngle:270];
	
	//Bottom arrow
	if (self.arrowEdge == NSMinYEdge) {
		CGFloat midX = NSMidX(insetRect);
		arrowPoints[0] = NSMakePoint(floor(midX - (arrowWidth / 2.0)), minY - radius); // Starting point
		arrowPoints[1] = NSMakePoint(floor(midX), arrowPoints[0].y - arrowHeight); // Arrow tip
		arrowPoints[2] = NSMakePoint(floor(midX + (arrowWidth / 2.0)), arrowPoints[0].y); // Ending point
		[path appendBezierPathWithPoints:arrowPoints count:3];
	}
		
	//Bottom right corner
	[path appendBezierPathWithArcWithCenter:NSMakePoint(maxX, minY) radius:radius startAngle:270 endAngle:360];
	
	//Right arrow
	if (self.arrowEdge == NSMaxXEdge) {
		CGFloat midY = NSMidY(insetRect);
		arrowPoints[0] = NSMakePoint(maxX + radius, floor(midY - (arrowWidth / 2.0)));
		arrowPoints[1] = NSMakePoint(arrowPoints[0].x + arrowHeight, floor(midY));
		arrowPoints[2] = NSMakePoint(arrowPoints[0].x, floor(midY + (arrowWidth / 2.0)));
		[path appendBezierPathWithPoints:arrowPoints count:3];
	}
		
	// Top right corner
	[path appendBezierPathWithArcWithCenter:NSMakePoint(maxX, maxY) radius:radius startAngle:0 endAngle:90];
	
	//Top arrow
	if (self.arrowEdge == NSMaxYEdge) {
		CGFloat midX = NSMidX(insetRect);
		arrowPoints[0] = NSMakePoint(floor(midX + (arrowWidth / 2.0)), maxY + radius);
		arrowPoints[1] = NSMakePoint(floor(midX), arrowPoints[0].y + arrowHeight);
		arrowPoints[2] = NSMakePoint(floor(midX - (arrowWidth / 2.0)), arrowPoints[0].y);
		[path appendBezierPathWithPoints:arrowPoints count:3];
	}
		
	//Top left corner
	[path appendBezierPathWithArcWithCenter:NSMakePoint(minX, maxY) radius:radius startAngle:90 endAngle:180];
	
	//Left arrow
	if (self.arrowEdge == NSMinXEdge) {
		CGFloat midY = NSMidY(insetRect);
		arrowPoints[0] = NSMakePoint(minX - radius, floor(midY + (arrowWidth / 2.0)));
		arrowPoints[1] = NSMakePoint(arrowPoints[0].x - arrowHeight, floor(midY));
		arrowPoints[2] = NSMakePoint(arrowPoints[0].x, floor(midY - (arrowWidth / 2.0)));
		[path appendBezierPathWithPoints:arrowPoints count:3];
	}
	
	[path closePath];
	
	return path;
}
@end
