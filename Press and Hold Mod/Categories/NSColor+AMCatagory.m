//  NSView+ViewDebugging.m
//  Created by Jimmy Hough Jr on 7/21/14.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "NSColor+AMCatagory.h"

@implementation NSColor (AMCatagory)

+ (NSColor *)colorWithCalibratedRedHex:(Byte)redByte
							  greenHex:(Byte)greenByte
							   blueHex:(Byte)blueByte
							  alphaHex:(Byte)alphaByte {
	return [NSColor colorWithCalibratedRed: (CGFloat) redByte / 0xFF
									 green: (CGFloat) greenByte / 0xFF
									  blue: (CGFloat) blueByte / 0xFF
									 alpha: (CGFloat) alphaByte / 0xFF];
}

@end
