//  Press_and_Hold_Mod.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPressAndHoldPrefController.h"
#import "AMLocaleUtilities.h"
#import "NSView+ViewDebugging.h"


@implementation AMPressAndHoldPrefController

#pragma mark NSPreferencePane methods
- (void)mainViewDidLoad {
    //create new model object
	_model = [[AMPressAndHoldPlistModel alloc] init];
	
	/*****Setup main views*****/
	//populate drop down menu with the array of supported languages.
	NSArray *userISPrefs = [AMLocaleUtilities userInputSourcePreferences]; //User's Input Source Preferences
	NSArray *supportedLanguages = [_model sortedLanguageList]; //All supported languages
	NSPredicate *intersectPredicate = [NSPredicate predicateWithFormat:@"SELF IN %@", supportedLanguages];
	NSArray *filteresdUserISPrefs = [userISPrefs filteredArrayUsingPredicate:intersectPredicate]; //All supported User Input Source Preferences
	NSArray *sortedUserISPrefs = [filteresdUserISPrefs sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	
	[self.popUpButton addItemsWithTitles: sortedUserISPrefs];
	[self.popUpButton selectItemWithTitle: filteresdUserISPrefs[0]];
	[self updateInputSource];
	
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

	/*****Observe Input Source Changes*****/
	[[NSDistributedNotificationCenter defaultCenter] addObserver: self
														selector: @selector(inputSourceChanged)
															name: (NSString *)kTISNotifySelectedKeyboardInputSourceChanged
														  object: nil];
	//[self.mainView logHierarchy];
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
}

#pragma mark AMKeyboardViewControllerDelegate methods
- (void) keyboard:(AMKeyboardView *) keyboard virtualKeyDownFromButton:(NSButton *)sender ForEvent:(NSEvent *)event {
	if ([AMLocaleUtilities isCharacterForKeycode: event.keyCode]) {
		NSLog(@"%@", event);
		NSArray *stringArray = [_model stringArrayForPlistKey: _currentPlist CharacterKey: [sender title]];
		[self.popoverController showWindow: sender withStringArray: stringArray];
	}
}

#pragma mark IBActions
- (IBAction) popUpButtonChanged:(NSPopUpButton *)sender {
	[self updateInputSource];
}

#pragma mark IBActions (testing)
- (IBAction)testButton1Pressed:(NSButton *)sender {
	[self.popover showRelativeToRect: sender.bounds ofView: sender preferredEdge: NSMinYEdge];
}

- (IBAction)testButton2Pressed:(NSButton *)sender {
	[self.popoverController close];
}

#pragma mark Other methods
- (void) inputSourceChanged {
	[self updateInputSource];
}

- (void) updateInputSource {
	_currentPlist = self.popUpButton.titleOfSelectedItem;
	NSString *fileContents = [_model fileContentsForPlistKey: _currentPlist];
	[self.textView setString: fileContents];
	
	[_keyboardController rebuildKeyLayout];
}


@end
