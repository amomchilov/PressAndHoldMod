//  AMPopoverView.h
//  Created by Alexander Momchilov on 2014-08-11.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "NSColor+AMCatagory.h"

/**
 @brief  An NSView subclass intented to be used as the contentView of an AMPopoverPanel.
 */
@interface AMPopoverView : NSView

/**
 @brief  The background color of the AMPopoverPanel
 */
@property NSColor *backgroundColor;

/**
 @brief  The border color of the AMPopoverPanel
 */
@property NSColor *borderColor;

/**
 @brief  The frame of the contentView, adjusted for the arrow position
 */
@property NSRect popUpRect;

/**
 @brief  The corner radius of the AMPopoverPanel (set to 0 for sharp corners)

 This does not effect the external or internal dimmesions of the AMPopoverPanel
 */
@property float cornerRadius;

/**
 @brief  The border width of the AMPopoverPanel
 */
@property int borderWidth;

/**
 @brief  The size of the arrow, such that:

 - The height is ALWAYS measured as the distance away from the edge
 - The width is ALWAYS measured as the distance along the edge
 */
@property NSSize arrowSize;

/**
 @brief  The edge onto which the arrow is protruding from

 The AMPopoverPanel is automatically positioned behind the arrow
 */
@property NSRectEdge arrowEdge;

/**
 @brief  The position of the arrow along its edge (clockwise)

 Set to -1 to have the arrow automatically center on its edge
 The AMPopoverPanel is automatically positioned to ensure the correct arrow placement
 */
@property CGFloat arrowPosition;

/**
 @brief Creates an NSPopover shaped curve with the given parameters.

 @param rect           The outer dimmensions of the AMPopoverView
 @param radius         The corner radius of the AMPopoverView
 @param borderWidth    The border width of the AMPopoverView
 @param arrowSize      The size of the arrow, such that:
 - The height is ALWAYS measured as the distance away from the edge
 - The width is ALWAYS measured as the distance along the edge
 @param arrowEdge The edge onto which the arrow is protruding from
 The AMPopoverPanel is automatically positioned behind the arrow
 @param arrowPosition  The position of the arrow along its edge (clockwise)
 Set to -1 to have the arrow automatically center on its edge

 @return An NSPopover shaped curve with the given parameters.
 */
+ (NSBezierPath *) BezierPathWithRect:(NSRect) rect
							   radius:(float) radius
						   borderWith:(float) borderWidth
							arrowSize:(NSSize) arrowSize
							arrowEdge:(NSRectEdge) arrowEdge
			   arrowPositionAlongEdge:(float) arrowPosition;

@end