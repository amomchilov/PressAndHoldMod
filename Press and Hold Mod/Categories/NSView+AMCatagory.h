//  NSView+ViewDebugging.h
//  Created by Jimmy Hough Jr on 7/21/14.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>

/**
 @brief  A convenience catagory for extending NSView with useful methods
 */
@interface NSView (AMCatagory)

/**
 @brief  Produces a hierarchical string that describes a view and its subviews.

 @param view  The view whose subviews are to be described
 @param level The depth to which the subviews are crawled

 @return A hierarchical string that describes a view and its subviews.
 */
+ (NSString *)hierarchicalDescriptionOfView:(NSView *)view
                                      level:(NSUInteger)level;

/**
 @brief  Logs a view's hierarchy.
 
 @see hierarchicalDescriptionOfView:level:
 */
- (void)logHierarchy;

/**
 @brief  Produces an NSRect that represents the true bounds of a view, adjusted for the views alignmentRectInsets.

 @return The bounds of the view, adjusted for the views alignmentRectInsets.
 */
- (NSRect) actualBounds;
@end
