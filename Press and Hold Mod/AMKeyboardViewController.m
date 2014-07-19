//
//  AMKeyboardViewController.m
//  Press and Hold Mod
//
//  Created by Alexander Momchilov on 2014-07-18.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.
//

#import "AMKeyboardViewController.h"

@interface AMKeyboardViewController ()

@end

@implementation AMKeyboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self.view becomeFirstResponder];
    }
    return self;
}

- (IBAction)virtualKeyPressed:(NSButton *)sender {
	[self.delegate keyboard: self.view didPressKey:sender];
	//[self.delegate keyboard:self didPressKey:sender];
}

@end
