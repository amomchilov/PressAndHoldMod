//  AMPopoverView.m
//  Created by Alexander Momchilov on 2014-08-11.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPopoverView.h"

@implementation AMPopoverView

#pragma mark NSView methods
- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
	
	[[NSGraphicsContext currentContext] saveGraphicsState];

	NSBezierPath *path = [self popUpBezierPathWithRect: self.panel.contentRect
												radius: self.panel.cornerRadius
											borderWith: self.panel.borderWidth
										arrowDirection: self.panel.arrowEdge
								arrowPositionAlongEdge: self.panel.arrowPosition
											 arrowSize: self.panel.arrowSize];
	
	[path setLineWidth: self.panel.borderWidth];
	[self.panel.viewBackgroundColor setFill];
	[path fill];
	[self.panel.borderColor setStroke];
	[path setClip];
	[path stroke];
	
	
	[[NSGraphicsContext currentContext] restoreGraphicsState];
}

#pragma mark Other methods

- (AMPopoverPanel *) panel {
	return (AMPopoverPanel *) self.window;
}

- (NSBezierPath *)popUpBezierPathWithRect:(NSRect) rect
								   radius:(float) radius
							   borderWith:(float) borderWidth
						   arrowDirection:(NSRectEdge) arrowDirection
				   arrowPositionAlongEdge:(float) arrowPosition
								arrowSize:(NSSize) arrowSize {
	const CGFloat minX = NSMinX(rect);
	const CGFloat maxX = NSMaxX(rect);
	const CGFloat minY = NSMinY(rect);
	const CGFloat maxY = NSMaxY(rect);
	
	//Arrow is oriented like: /\ with the points defined from right to left
	NSPoint arrowPoints[] = {NSMakePoint(arrowSize.width, 0),						//bottom right point
							 NSMakePoint(arrowSize.width / 2, arrowSize.height),	//tip
							 NSZeroPoint};											//bottom left point
	Byte arrowPointsCount = sizeof(arrowPoints)/sizeof(arrowPoints[0]);
	
	NSAffineTransform *t = [NSAffineTransform transform];
	
	NSBezierPath *path = [NSBezierPath bezierPath]; //the path to be assembled, counterclockwise from the top right
	[path setLineJoinStyle: NSRoundLineJoinStyle];	

	//Bottom left corner
	[path appendBezierPathWithArcWithCenter: NSMakePoint(minX + radius, minY + radius) radius: radius startAngle: 180 endAngle: 270];
	
	//Bottom arrow
	if (arrowDirection == NSMinYEdge) {
		[t translateXBy: minX + arrowPosition + arrowSize.width / 2.0 yBy: minY];
		[t rotateByDegrees: 180];
		for (int i = 0; i < arrowPointsCount; i ++) arrowPoints[i] = [t transformPoint: arrowPoints[i]];
		[path appendBezierPathWithPoints: arrowPoints count: arrowPointsCount];
	}
	
	//Bottom right corner
	[path appendBezierPathWithArcWithCenter: NSMakePoint(maxX - radius, minY + radius) radius: radius startAngle: 270 endAngle:   0];
	
	//Right arrow
	if (arrowDirection == NSMaxXEdge) {
		[t translateXBy: maxX yBy: minY + arrowPosition + arrowSize.width / 2.0];
		[t rotateByDegrees: 270];
		for (int i = 0; i < arrowPointsCount; i ++) arrowPoints[i] = [t transformPoint: arrowPoints[i]];
		[path appendBezierPathWithPoints: arrowPoints count: arrowPointsCount];
	}
	
	//Top right corner
	[path appendBezierPathWithArcWithCenter: NSMakePoint(maxX - radius, maxY - radius) radius: radius startAngle:   0 endAngle:  90];
	
	//Top arrow
	if (arrowDirection == NSMaxYEdge) {
		[t translateXBy: minX + arrowPosition - arrowSize.width / 2.0 yBy: maxY];
		for (int i = 0; i < arrowPointsCount; i ++) arrowPoints[i] = [t transformPoint: arrowPoints[i]];
		[path appendBezierPathWithPoints: arrowPoints count: arrowPointsCount];
	}
	
	//Top left corner
	[path appendBezierPathWithArcWithCenter: NSMakePoint(minX + radius, maxY - radius) radius: radius startAngle:  90 endAngle: 180];
	
	//Left arrow
	if (arrowDirection == NSMinXEdge) {
		[t translateXBy: minX yBy: minY + arrowPosition - arrowSize.width / 2.0];
		[t rotateByDegrees: 90];
		for (int i = 0; i < arrowPointsCount; i ++) arrowPoints[i] = [t transformPoint: arrowPoints[i]];
		[path appendBezierPathWithPoints: arrowPoints count: arrowPointsCount];
	}
	
	[path closePath];
	return path;
}

@end
