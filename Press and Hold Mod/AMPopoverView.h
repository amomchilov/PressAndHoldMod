//  AMPopoverView.h
//  Created by Alexander Momchilov on 2014-08-11.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "NSColor+HexColorCode.h"

@interface AMPopoverView : NSView

@property NSColor *backgroundColor;
@property NSColor *borderColor;
//@property NSColor *topHighlightColor;
@property int borderWidth;
@property CGFloat cornerRadius;
@property NSSize arrowSize;
@property NSRectEdge arrowEdge;

@end