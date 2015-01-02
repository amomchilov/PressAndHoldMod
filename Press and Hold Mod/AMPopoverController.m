//  AMPopoverController.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPopoverController.h"


@implementation AMPopoverController

#pragma mark initializers
- (instancetype) initWithContentViewNib:(NSString *) nibName {
	return [self initWithContentViewController: [[NSViewController alloc] initWithNibName: nibName
																				   bundle: [NSBundle bundleForClass: self.class]]];
}

- (instancetype) initWithContentViewController:(NSViewController *) vc  {
	NSView *v = vc.view;
	if ([v.class isSubclassOfClass: AMPopoverView.class]) {
		return [self initWithContentView: (AMPopoverView *) vc.view];
	}
	else {
		@throw [NSException exceptionWithName: @"IllegalArugment"
									   reason: @"AMPopoverController's AMPopoverPanel's contentView MUST be a subclass of AMPopoverView"
									 userInfo: nil];
	}
}

- (instancetype) initWithContentView:(AMPopoverView *) view {
	AMPopoverPanel *w = [[AMPopoverPanel alloc] initWithContentRect: NSZeroRect
														  styleMask: NSBorderlessWindowMask
															backing: NSBackingStoreBuffered
															  defer: NO];
    if (self = [super initWithWindow: w]) {
		self.window.delegate = self;

		[self contentView: view];
    }
    return self;
}

//- (void)windowDidLoad {
//	DLog(@"");
//	[super windowDidLoad];
//}

#pragma mark Other methods
- (AMPopoverPanel *) windowAsAMPopoverPanel {
	return (AMPopoverPanel *) self.window;
}

- (AMPopoverView *) contentView {
	return self.window.contentView;
}

- (void) contentView:(AMPopoverView *) newView {
	self.window.contentView = newView;
}

- (void) popoverWithSize:(NSSize) contentSize
				  onView:(NSView *) sender
			 borderWidth:(int) newBorderWidth
			cornerRadius:(float) newCornerRadius
			   arrowSize:(NSSize) newArrowSize
			   arrowEdge:(NSRectEdge) newArrowEdge
		   arrowPosition:(float) newArrowPosition
				 display:(BOOL) display {

	NSRect senderRect = sender.actualBounds;
	CGFloat x = senderRect.origin.x;
	CGFloat y = senderRect.origin.y;
	switch (newArrowEdge) {
		case NSMinYEdge: //arrow pointing up, box below
		newArrowEdge = NSMaxYEdge;
		x += senderRect.size.width/2;
		break;

		case NSMaxYEdge: //arrow pointing down, box above
		newArrowEdge = NSMinYEdge;
		x += senderRect.size.width/2;
		y += senderRect.size.height;
		break;

		case NSMinXEdge: //arrow pointing right, box on the left
		newArrowEdge = NSMaxXEdge;
		y += senderRect.size.height/2;
		break;

		case NSMaxXEdge: //arrow pointing left, box on the right
		newArrowEdge = NSMinXEdge;
		x += senderRect.size.width;
		y += senderRect.size.height/2;
		break;
	}

	[self popoverWithFrame: NSMakeRect(x, y, contentSize.width, contentSize.height)
			   borderWidth: newBorderWidth
			  cornerRadius: newCornerRadius
				 arrowSize: newArrowSize
				 arrowEdge: newArrowEdge
			 arrowPosition: newArrowPosition
				   display: display];
}

- (void) popoverWithFrame:(NSRect) frame
			  borderWidth:(int) newBorderWidth
			 cornerRadius:(float) newCornerRadius
				arrowSize:(NSSize) newArrowSize
				arrowEdge:(NSRectEdge) newArrowEdge
			arrowPosition:(float) newArrowPosition
				  display:(BOOL) display {

	AMPopoverView *v = self.contentView;

	newBorderWidth *= 2; //border is originally centered on the edge, so half is hidden.
	frame.size.height += newBorderWidth; //adjusts for thickeness of border
	frame.size.width += newBorderWidth;

	NSRect newContentRect = frame;
	newContentRect.origin = NSZeroPoint;
	switch (v.arrowEdge = newArrowEdge) {
		case NSMaxYEdge: //arrow pointing up, box below
		if (newArrowPosition == -1 || newArrowPosition >= frame.size.width) newArrowPosition = frame.size.width/2; //if the newArrowPosition is -1 or too big, newArrowPosition becomes such that the arrow is centered on its edge
		frame.size.height += newArrowSize.height; //makes room for the arrow
		frame.origin.y -= frame.size.height; //shifts the frame below the desired point
		frame.origin.x -= newArrowPosition; //shifts horizontally so the arrow lines up with the desired point
		break;

		case NSMinYEdge: //arrow pointing down, box above
		if (newArrowPosition == -1 || newArrowPosition >= frame.size.width) newArrowPosition = frame.size.width/2; //if the newArrowPosition is -1 or too big, newArrowPosition becomes such that the arrow is centered on its edge
		newContentRect.origin.y += newArrowSize.height; //shifts the contentRect above the desired point

		frame.size.height += newArrowSize.height; //makes room for the arrow
		frame.origin.x -= newArrowPosition; //shifts horizontally so the arrow lines up with the desired point
		break;

		case NSMaxXEdge: //arrow pointing right, box on the left
		if (newArrowPosition == -1 || newArrowPosition >= frame.size.height) newArrowPosition = frame.size.height/2; //if the newArrowPosition is -1 or too big, newArrowPosition becomes such that the arrow is centered on its edge
		frame.size.width += newArrowSize.height;  //makes room for the arrow
		frame.origin.x -= frame.size.width; //shifts the frame to the left of the desired point
		frame.origin.y -= newArrowPosition; //shifts vertically so the arrow lines up with the desired point
		break;

		case NSMinXEdge: //arrow pointing left, box on the right
		if (newArrowPosition == -1 || newArrowPosition >= frame.size.height) newArrowPosition = frame.size.height/2; //if the newArrowPosition is -1 or too big, newArrowPosition becomes such that the arrow is centered on its edge
		newContentRect.origin.x += newArrowSize.height; //shifts the contentRect to the right of the desired point

		frame.size.width += newArrowSize.height;  //makes room for the arrow
		frame.origin.y -= newArrowPosition; //shifts vertically so the arrow lines up with the desired point
		break;
	}

	v.popUpRect = newContentRect;
	v.borderWidth = newBorderWidth;
	v.cornerRadius = newCornerRadius;
	v.arrowSize = newArrowSize;
	v.arrowPosition = newArrowPosition;

	[self.window setFrame: frame display: display];
}

- (void) showWindow:(NSView *)sender withStringArray: (NSArray*) stringArray {

	[self popoverWithSize: NSMakeSize(3 + 26 * (stringArray.count + 1), 45) //TODO: width is fucked.
				   onView: sender
			  borderWidth: 1
			 cornerRadius: 4
				arrowSize: NSMakeSize(9, 6)
				arrowEdge: NSMaxYEdge
			arrowPosition: 10
				  display: YES];

	if (stringArray) {
		NSMutableString *labelString = [NSMutableString stringWithCapacity: 18];
		for (NSString *s in stringArray) {
			[labelString appendFormat: @"%@ ", s];
		}
//		self.window.AsAMPopoverPanel.label.stringValue = labelString;
	}
	else {
		//default case
	}
	
	[super showWindow: sender];
}

- (BOOL) windowShouldClose:(id)sender {
	return YES;
}

@end
