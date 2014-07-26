//  AMPopover.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPopoverPanel.h"

@implementation AMPopoverPanel

#pragma mark NSWindow methods
- (void) setContentView:(NSView *)aView {
//    aView.wantsLayer = YES;
//    aView.layer.frame = aView.frame;
//    aView.layer.cornerRadius = 20.0;
//    aView.layer.masksToBounds = YES;
//	aView.layer.opacity = 0.8;
//
	[super setContentView:aView];
}

- (BOOL) canBecomeKeyWindow { return YES; }

#pragma mark NSResponder methods
- (void)cancelOperation:(id)sender {
	[self.delegate popOver: self cancelOperation: sender];
}

@end
