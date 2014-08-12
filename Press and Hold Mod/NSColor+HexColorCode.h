//  NSView+ViewDebugging.h
//  Created by Jimmy Hough Jr on 7/21/14.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>

@interface NSColor (HexColorCode)

+ (NSColor *)colorWithCalibratedRedHex:(Byte)red
							  greenHex:(Byte)green
							   blueHex:(Byte)blue
							  alphaHex:(Byte)alpha;

@end
