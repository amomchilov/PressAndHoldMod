//  AMPopoverController.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "AMPopoverPanel.h"
#import "AMPopoverView.h"
#import "AMCharPopoverView.h"
#import "NSView+AMCatagory.h"

/**
 @brief  A NSWindowController subclass which controls an AMPopoverPanel
 */
@interface AMPopoverController : NSWindowController <NSWindowDelegate>

- (instancetype) initWithContentViewNib:(NSString *) nibName;

- (instancetype) initWithContentViewNib:(NSString *) nibName Bundle:(NSBundle *) bundle;

- (instancetype) initWithContentViewController:(NSViewController *) vc;

- (instancetype) initWithContentView:(AMPopoverView *) view;

/**
 @brief  Returns the window as an AMPopoverPanel

 @return The window as an AMPopoverPanel
 */
- (AMPopoverPanel *) windowAsAMPopoverPanel;

/**
 @brief This method will dynamically produce an AMPopoverPanel around an NSView with the given parameters and display it.

 @param contentSize            The dimmenstions of the AMPopoverPanel, such that:
 - The size of the frame represents the area within the AMPopoverPanel (which is colored with newViewBackgroundColor). These dimmensions are the inside of the border.
 @param sender				   The NSView about which the AMPopoverPanel will be automatically positioned.
 @param newBorderWidth         The border width of the AMPopoverPanel
 The external dimmensions of the AMPopoverPanel are the frame.size, outset by newBorderWidth
 @param newCornerRadius        The corner radius of the AMPopoverPanel (set to 0 for sharp corners)
 This does not effect the external or internal dimmesions of the AMPopoverPanel
 @param newArrowSize           The size of the arrow, such that
 - The height is ALWAYS measured as the distance away from the edg
 - The width is ALWAYS measured as the distance along the edg
 @param newArrowEdge           The edge onto which the arrow is protruding fro
 The AMPopoverPanel is automatically positioned behind the arro
 @param newArrowPosition       The position of the arrow along its edge (clockwise)
 Set to -1 to have the arrow automatically center on its edg
 The AMPopoverPanel is automatically positioned to ensure the correct arrow placemen
 @param dislpay				   Determines if the window should display after creation

 @see popoverWithFrame:backgroundColor:borderColor:borderWidth:cornerRadius:arrowSize:arrowEdge:arrowPosition:

 @warning Care should be taken to ensure the parameters are valid and can produce a tangible shape!
 */
- (void) popoverWithSize:(NSSize) contentSize
				  onView:(NSView *) sender
			 borderWidth:(int) newBorderWidth
			cornerRadius:(float) newCornerRadius
			   arrowSize:(NSSize) newArrowSize
			   arrowEdge:(NSRectEdge) newArrowEdge
		   arrowPosition:(float) newArrowPosition
				 display:(BOOL) display;

/**
 @brief This method will dynamically produce an AMPopoverPanel with the given parameters and display it.

 @param frame                  The frame of the AMPopoverPanel, such that:
 - The origin of the frame represents the arrow tip, about which the rest of the box is positioned
 - The size of the frame represents the area within the AMPopoverPanel (which is colored with newViewBackgroundColor). These dimmensions are the inside of the border.
 @param newBorderWidth         The border width of the AMPopoverPanel
 The external dimmensions of the AMPopoverPanel are the frame.size, outset by newBorderWidth
 @param newCornerRadius        The corner radius of the AMPopoverPanel (set to 0 for sharp corners)
 This does not effect the external or internal dimmesions of the AMPopoverPanel
 @param newArrowSize           The size of the arrow, such that:
 - The height is ALWAYS measured as the distance away from the edge
 - The width is ALWAYS measured as the distance along the edge
 @param newArrowEdge           The edge onto which the arrow is protruding from
 The AMPopoverPanel is automatically positioned behind the arrow
 @param newArrowPosition       The position of the arrow along its edge (clockwise)
 Set to -1 to have the arrow automatically center on its edge
 The AMPopoverPanel is automatically positioned to ensure the correct arrow placement
 @param dislpay				   Determines if the window should display after creation

 @warning Care should be taken to ensure the parameters are valid and can produce a tangible shape!
 */
- (void) popoverWithFrame:(NSRect) frame
			  borderWidth:(int) newBorderWidth
			 cornerRadius:(float) newCornerRadius
				arrowSize:(NSSize) newArrowSize
				arrowEdge:(NSRectEdge) newArrowEdge
			arrowPosition:(float) newArrowPosition
				  display:(BOOL) display;

/**
 @brief  Shows an AMPopoverPanel, such that the arrowtip is positioned at the center of the top of the sender NSView
 
 @param sender      The view about which the new AMPopoverPanel is to be placed
 @param stringArray An array of the strings to be placed in the AMPopoverPanel
 */
- (void) showWindow:(NSView *)sender withStringArray: (NSArray*) stringArray;

@end
