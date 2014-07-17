//  Press_and_Hold_Mod.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPressAndHoldPrefController.h"
#import "AMLocaleUtility.h"

@implementation AMPressAndHoldPrefController

- (id)initWithBundle:(NSBundle *)bundle {
    DLog(@"")
    if (self = [super initWithBundle:bundle]){
        
    }
    return self;
}

- (void)mainViewDidLoad {
    DLog(@"");
    [self setupModel];
    [self setupKeyboardView];
}

- (void)setupModel {
    DLog(@"");
    //create new model object
	_model = [[AMPressAndHoldPlistModel alloc] init];
	
	//populate drop down menu with the array of human readable names.
	[_popUpButton addItemsWithTitles: [_model sortedLanguageList]];
	
	//If the current locale is on the list, select it.
	if ([[_model plistFiles] objectForKey:[AMLocaleUtility userLanguagePreference]]) {
		[_popUpButton selectItemWithTitle:[AMLocaleUtility userLanguagePreference]];
		[self readPlistFileIntoTextField];
	}
}

- (void)setupKeyboardView {
    DLog(@"");
    NSViewController *vc = [[NSViewController alloc] initWithNibName:@"AMKeyboardView"
                                                              bundle:[self bundle]];
    
	[_keyboardView addSubview: [vc view]];
    
    [self addActionsToKeyboardButtons];
}

- (void)addActionsToKeyboardButtons {
    DLog(@"");
    for (NSView *view in [(NSView*)_keyboardView.subviews[0] subviews]) {
        
        if ([view isKindOfClass:[NSButton class]]) {
            NSButton *button = (NSButton*)view;
            button.target = self;
            button.action = @selector(virtualKeyPressed:);
        }
    }
}

- (IBAction) popUpButtonChanged:(id)sender {
    DLog(@"");
	[self readPlistFileIntoTextField];
}

- (void) readPlistFileIntoTextField {
    DLog(@"");

	NSString *fileContents = [_model readPlistFileContentsForKey: [_popUpButton titleOfSelectedItem]];
	[_textView setString: fileContents];
}

- (void) virtualKeyPressed: (id) sender {
    DLog(@"%@ pressed", [(NSButton*)sender title]);
}
@end
