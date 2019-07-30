//  NSView+ViewDebugging.h
//  Created by Jimmy Hough Jr on 7/21/14.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>

/**
 @brief  A convenience catagory for extending NSColor with useful methods
 */
@interface NSColor (AMCatagory)

/**
 @brief  Creates an NSColour with Byte components (0-255).
 

 @discussion This is especially useful for using hexidimal notation for creating colors.
 For example, #66CCFF (in the form of #RRGGBB) with 100% opacity (0xFF66CCFF, in the form of 0xAARRGGBB), can be created with:

	[NSColor colorWithCalibratedRedHex: 0x66
							  greenHex: 0xCC
							   blueHex: 0xFF
							  alphaHex: 0xFF];


 @param red   The red component of the color
 @param green The green component of the color
 @param blue  The blue component of the color
 @param alpha The alpha component of the color

 @return A new NSColor isntance with the given parameters
 */
+ (NSColor *)colorWithCalibratedRedHex:(Byte)red
							  greenHex:(Byte)green
							   blueHex:(Byte)blue
							  alphaHex:(Byte)alpha;

@end
