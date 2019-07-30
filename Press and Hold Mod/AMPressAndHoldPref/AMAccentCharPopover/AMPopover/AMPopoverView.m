//  AMPopoverView.m
//  Created by Alexander Momchilov on 2014-08-11.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPopoverView.h"

@implementation AMPopoverView

#pragma mark NSView methods
- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
	
	[[NSGraphicsContext currentContext] saveGraphicsState];

	NSBezierPath *path = [AMPopoverView BezierPathWithRect: self.popUpRect
													radius: self.cornerRadius
												borderWith: self.borderWidth
												 arrowSize: self.arrowSize
												 arrowEdge: self.arrowEdge
									arrowPositionAlongEdge: self.arrowPosition];
	
	[path setLineWidth: self.borderWidth];
	[self.backgroundColor setFill];
	[path fill];
	[self.borderColor setStroke];
	[path setClip];
	[path stroke];
	
	
	[[NSGraphicsContext currentContext] restoreGraphicsState];
}

#pragma mark Other methods

+ (NSBezierPath *) BezierPathWithRect:(NSRect) rect
							   radius:(float) radius
						   borderWith:(float) borderWidth
							arrowSize:(NSSize) arrowSize
							arrowEdge:(NSRectEdge) arrowEdge
			   arrowPositionAlongEdge:(float) arrowPosition {
	const float minX = NSMinX(rect);
	const float maxX = NSMaxX(rect);
	const float minY = NSMinY(rect);
	const float maxY = NSMaxY(rect);
	
	//Arrow is oriented like: /\ with the points defined from right to left
	NSPoint arrowPoints[] = {NSMakePoint(arrowSize.width, 0),						//bottom right point
							 NSMakePoint(arrowSize.width / 2, arrowSize.height),	//tip
							 NSZeroPoint};											//bottom left point
	Byte arrowPoints_Size = sizeof(arrowPoints)/sizeof(*arrowPoints);
	
	NSAffineTransform *t = [NSAffineTransform transform];
	
	NSBezierPath *path = [NSBezierPath bezierPath]; //the path to be assembled, counterclockwise from the top right
	[path setLineJoinStyle: NSRoundLineJoinStyle];	

	//Bottom left corner
	[path appendBezierPathWithArcWithCenter: NSMakePoint(minX + radius, minY + radius) radius: radius startAngle: 180 endAngle: 270];
	
	//Bottom arrow
	if (arrowEdge == NSMinYEdge) {
		[t translateXBy: minX + arrowPosition + arrowSize.width / 2.0 yBy: minY];
		[t rotateByDegrees: 180];
		for (int i = 0; i < arrowPoints_Size; i ++) arrowPoints[i] = [t transformPoint: arrowPoints[i]];
		[path appendBezierPathWithPoints: arrowPoints count: arrowPoints_Size];
	}
	
	//Bottom right corner
	[path appendBezierPathWithArcWithCenter: NSMakePoint(maxX - radius, minY + radius) radius: radius startAngle: 270 endAngle:   0];
	
	//Right arrow
	if (arrowEdge == NSMaxXEdge) {
		[t translateXBy: maxX yBy: minY + arrowPosition + arrowSize.width / 2.0];
		[t rotateByDegrees: 270];
		for (int i = 0; i < arrowPoints_Size; i ++) arrowPoints[i] = [t transformPoint: arrowPoints[i]];
		[path appendBezierPathWithPoints: arrowPoints count: arrowPoints_Size];
	}
	
	//Top right corner
	[path appendBezierPathWithArcWithCenter: NSMakePoint(maxX - radius, maxY - radius) radius: radius startAngle:   0 endAngle:  90];
	
	//Top arrow
	if (arrowEdge == NSMaxYEdge) {
		[t translateXBy: minX + arrowPosition - arrowSize.width / 2.0 yBy: maxY];
		for (int i = 0; i < arrowPoints_Size; i ++) arrowPoints[i] = [t transformPoint: arrowPoints[i]];
		[path appendBezierPathWithPoints: arrowPoints count: arrowPoints_Size];
	}
	
	//Top left corner
	[path appendBezierPathWithArcWithCenter: NSMakePoint(minX + radius, maxY - radius) radius: radius startAngle:  90 endAngle: 180];
	
	//Left arrow
	if (arrowEdge == NSMinXEdge) {
		[t translateXBy: minX yBy: minY + arrowPosition - arrowSize.width / 2.0];
		[t rotateByDegrees: 90];
		for (int i = 0; i < arrowPoints_Size; i ++) arrowPoints[i] = [t transformPoint: arrowPoints[i]];
		[path appendBezierPathWithPoints: arrowPoints count: arrowPoints_Size];
	}
	
	[path closePath];
	return path;
}

@end
