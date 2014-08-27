//  AMPopover.h
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "AMPopoverView.h"
#import "NSView+AMCatagory.h"

@interface AMPopoverPanel : NSPanel

/**
 @brief  The frame of the contentView, adjusted for the arrow position

 @see popoverWithFrame:backgroundColor:borderColor:borderWidth:cornerRadius:arrowSize:arrowEdge:arrowPosition:
 */
@property (readonly) NSRect popUpRect;

/**
 @brief  The background color of the AMPopoverPanel

 @see popoverWithFrame:backgroundColor:borderColor:borderWidth:cornerRadius:arrowSize:arrowEdge:arrowPosition:
 */
@property (readonly) NSColor *viewBackgroundColor;

/**
 @brief  The border color of the AMPopoverPanel

 @see popoverWithFrame:backgroundColor:borderColor:borderWidth:cornerRadius:arrowSize:arrowEdge:arrowPosition:
 */
@property (readonly) NSColor *borderColor;

/**
 @brief  The border width of the AMPopoverPanel

 @see popoverWithFrame:backgroundColor:borderColor:borderWidth:cornerRadius:arrowSize:arrowEdge:arrowPosition:
 */
@property (readonly) int borderWidth;

/**
 @brief  The corner radius of the AMPopoverPanel (set to 0 for sharp corners)

 This does not effect the external or internal dimmesions of the AMPopoverPanel

 @see popoverWithFrame:backgroundColor:borderColor:borderWidth:cornerRadius:arrowSize:arrowEdge:arrowPosition:
 */
@property (readonly) float cornerRadius;

/**
 @brief  The size of the arrow, such that:

 - The height is ALWAYS measured as the distance away from the edge

 - The width is ALWAYS measured as the distance along the edge

 @see popoverWithFrame:backgroundColor:borderColor:borderWidth:cornerRadius:arrowSize:arrowEdge:arrowPosition:
 */
@property (readonly) NSSize arrowSize;

/**
 @brief  The edge onto which the arrow is protruding from

 The AMPopoverPanel is automatically positioned behind the arrow

 @see popoverWithFrame:backgroundColor:borderColor:borderWidth:cornerRadius:arrowSize:arrowEdge:arrowPosition:
 */
@property (readonly) NSRectEdge arrowEdge;

/**
 @brief  The position of the arrow along its edge (clockwise)

 Set to -1 to have the arrow automatically center on its edge

 The AMPopoverPanel is automatically positioned to ensure the correct arrow placement

 @see popoverWithFrame:backgroundColor:borderColor:borderWidth:cornerRadius:arrowSize:arrowEdge:arrowPosition:
 */
@property (readonly) CGFloat arrowPosition;

@property (weak) IBOutlet NSTextField *label;

/**
 @brief This method will dynamically produce an AMPopoverPanel around an NSView with the given parameters and display it.

 @param contentSize            The dimmenstions of the AMPopoverPanel, such that:

 - The size of the frame represents the area within the AMPopoverPanel (which is colored with newViewBackgroundColor). These dimmensions are the inside of the border.
 
 @param sender				   The NSView about which the AMPopoverPanel will be automatically positioned.

 @param newViewBackgroundColor The background color of the AMPopoverPanel

 @param newBorderColor         The border color of the AMPopoverPanel

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

 @see popoverWithFrame:backgroundColor:borderColor:borderWidth:cornerRadius:arrowSize:arrowEdge:arrowPosition:
 
 @warning Care should be taken to ensure the parameters are valid and can produce a tangible shape!
 */
- (void) popoverWithSize:(NSSize) contentSize
				  onView:(NSView *) sender
		 backgroundColor:(NSColor *) newViewBackgroundColor
			 borderColor:(NSColor *) newBorderColor
			 borderWidth:(int) newBorderWidth
			cornerRadius:(float) newCornerRadius
			   arrowSize:(NSSize) newArrowSize
			   arrowEdge:(NSRectEdge) newArrowEdge
		   arrowPosition:(float) newArrowPosition;

/**
 @brief This method will dynamically produce an AMPopoverPanel with the given parameters and display it.
 
 @param frame                  The frame of the AMPopoverPanel, such that:
 
  - The origin of the frame represents the arrow tip, about which the rest of the box is positioned
  - The size of the frame represents the area within the AMPopoverPanel (which is colored with newViewBackgroundColor). These dimmensions are the inside of the border.
 
 @param newViewBackgroundColor The background color of the AMPopoverPanel
 
 @param newBorderColor         The border color of the AMPopoverPanel
 
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
 
 @warning Care should be taken to ensure the parameters are valid and can produce a tangible shape!
 */
- (void) popoverWithFrame:(NSRect) frame
		  backgroundColor:(NSColor *) newViewBackgroundColor
			  borderColor:(NSColor *) newBorderColor
			  borderWidth:(int) newBorderWidth
			 cornerRadius:(float) newCornerRadius
				arrowSize:(NSSize) newArrowSize
				arrowEdge:(NSRectEdge) newArrowEdge
			arrowPosition:(float) newArrowPosition;
@end