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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (IBAction)virtualKeyPressed:(NSButton *)sender {
	//[self.delegate keyboard:self didPressKey:sender];
}

@end
