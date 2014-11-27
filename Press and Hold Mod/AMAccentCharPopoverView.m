//
//  AMAccentCharPopoverView.m
//  Press and Hold Mod
//
//  Created by Alexander Momchilov on 2014-11-12.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.
//

#import "AMAccentCharPopoverView.h"

@implementation AMAccentCharPopoverView

- (instancetype)initWithFrame:(NSRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [NSColor whiteColor];
		self.borderColor = [NSColor colorWithCalibratedRedHex: 0xC2
													 greenHex: 0xD7
													  blueHex: 0xFE
													 alphaHex: 0xFF];
	}
	return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    // Drawing code here.
}

@end
