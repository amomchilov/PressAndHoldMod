//  Press_and_Hold_Mod.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPressAndHoldPrefController.h"
#import "AMLocaleUtility.h"
#import "NSView+ViewDebugging.h"


@implementation AMPressAndHoldPrefController

- (void)mainViewDidLoad {
    //create new model object
	_model = [[AMPressAndHoldPlistModel alloc] init];
	
	/*****Setup main views*****/
	//populate drop down menu with the array of human readable names.
	[self.popUpButton addItemsWithTitles: [_model sortedLanguageList]];
	
	//If the current locale is on the list, select it.
	if ([[_model plistFiles] objectForKey:[AMLocaleUtility userLanguagePreference]]) {
		[self.popUpButton selectItemWithTitle:[AMLocaleUtility userLanguagePreference]];
		[self readPlistFileIntoTextField];
	}
	
	/*****Setup AMKeyboardView*****/
    _keyboardController = [[AMKeyboardViewController alloc] initWithNibName:@"AMKeyboardView"
																		 bundle:[self bundle]];
    _keyboardController.delegate = self;
	self.keyboardView = (AMKeyboardView *) [_keyboardController view];
	
	[self.keyboardView setFrame: self.keyboardPlaceHolder.frame];
    [self.keyboardPlaceHolder removeFromSuperview];

	[self.mainView addSubview: self.keyboardView];
	
	/*****Setup AMPopover*****/
	self.popoverController = [[AMPopoverController alloc] initWithWindowNibName:@"AMPopoverView"];
	
	[self.mainView logHierarchy];
}

//Notifies the receiver that the main application has just displayed the preference pane’s main view.
- (void)didSelect {
//	[self.mainView.window addObserver:self
//						   forKeyPath:@"firstResponder"
//							  options:NSKeyValueObservingOptionNew
//							  context:NULL];
	[self.mainView.window performSelector:@selector(makeFirstResponder:)
							   withObject:self.keyboardView
							   afterDelay:0.0];
}

//- (void) observeValueForKeyPath:(NSString *)keyPath
//					   ofObject:(id)object
//						 change:(NSDictionary *)change
//						context:(void *)context {
//	NSLog(@"New FR: %@", [change objectForKey: NSKeyValueChangeNewKey]);
//}

//Notifies the receiver that the main application is about to stop displaying the preference pane’s main view.
- (void) willUnselect {
	[self.popoverController close];
	//	[self.timer invalidate];
}

- (IBAction) popUpButtonChanged:(id)sender {
	[self readPlistFileIntoTextField];
}

- (void) readPlistFileIntoTextField {
	_currentPlist = [self.popUpButton titleOfSelectedItem];
	NSString *fileContents = [_model fileContentsForPlistKey: _currentPlist];
	[self.textView setString: fileContents];
}

- (void) keyboard:(NSView *) keyboard didPressKey:(NSButton *) sender {
	//DLog(@"%@", [sender title]);
	NSArray *stringArray = [_model stringArrayForPlistKey: _currentPlist CharacterKey: [sender title]];
	[self.popoverController showWindow: sender withStringArray: stringArray];
}

- (IBAction)testButton1Pressed:(NSButton *)sender {
	[self.popover showRelativeToRect: sender.bounds ofView: sender preferredEdge: NSMinYEdge];
}

- (IBAction)testButton2Pressed:(NSButton *)sender {
	[self.popoverController close];
}


@end
