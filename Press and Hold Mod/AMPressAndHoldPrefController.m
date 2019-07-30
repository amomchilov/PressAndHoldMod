//  Press_and_Hold_Mod.m
//  Created by Alexander Momchilov on 2014-07-15.
//  Copyright (c) 2014 Alexander Momchilov. All rights reserved.

#import "AMPressAndHoldPrefController.h"
#import "AMLocaleUtilities.h"
#import <objc/runtime.h>

@implementation AMPressAndHoldPrefController

#pragma mark NSPreferencePane methods
- (void) mainViewDidLoad {
	_model = [[AMPressAndHoldPlistModel alloc] init];
	
	/*****Setup main views*****/
	//populate drop down menu with the array of supported languages.
	NSArray *userISPrefs = [AMLocaleUtilities userLanguagePreferences]; //User's Input Source Preferences
	NSArray *supportedLanguages = [_model sortedLanguageList]; //All supported languages
	NSPredicate *intersectPredicate = [NSPredicate predicateWithFormat:@"SELF IN %@", supportedLanguages];
	NSArray *filteresdUserISPrefs = [userISPrefs filteredArrayUsingPredicate:intersectPredicate]; //All supported User Input Source Preferences
	NSArray *sortedUserISPrefs = [filteresdUserISPrefs sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	
	[self.languagesPopUpButton addItemsWithTitles: sortedUserISPrefs];
	[self.languagesPopUpButton selectItemWithTitle: filteresdUserISPrefs[0]];
	[self updateInputSource];
	
	/***** Setup AMKeyboardView *****/
    _keyboardController = [[AMKeyboardVC alloc]
						   initWithNibName:@"AMKeyboardView"
						   bundle: self.bundle];
    _keyboardController.delegate = self;
	self.keyboardView = (AMKeyboardView *) _keyboardController.view;
	
	self.keyboardView.frame = _keyboardPlaceHolder.frame;
    [_keyboardPlaceHolder removeFromSuperview];

	[self.mainView addSubview: self.keyboardView];
	
	/***** Setup AMPopover *****/
	NSViewController *popoverContentVC =
		[[NSViewController alloc] initWithNibName: @"AMCharPopover"
										   bundle: self.bundle];
	AMCharPopoverView *popoverContentV = (AMCharPopoverView *) popoverContentVC.view;
	_popoverController = [[AMPopoverController alloc] initWithContentView: popoverContentV];

	/***** Observe Input Source Changes *****/
	[[NSDistributedNotificationCenter defaultCenter] addObserver: self
														selector: @selector(updateInputSource)
															name: (NSString *)kTISNotifySelectedKeyboardInputSourceChanged
														  object: nil];
	/***** Observe changes to the popup's key window status *****/
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector: @selector(resignKeyWindow)
												 name: NSWindowDidResignKeyNotification
											   object: _popoverController.window];
}

//Notifies the receiver that the main application has just displayed the preference pane’s main view.
- (void) didSelect {
	/* Below is the most unorthadox hack to solve the most fucking annoying issue. For some magical reason, something else claims first responder status after didSelect, so first responder status is obtained after a tiny delay.
	 */
	[self.mainView.window performSelector: @selector(makeFirstResponder:)
							   withObject: self.keyboardView
							   afterDelay: 0.01];
}

//Notifies the receiver that the main application is about to stop displaying the preference pane’s main view.
- (void) willUnselect {
	[_popoverController close];
}

#pragma mark AMKeyboardVCDelegate methods
- (void) keyDown:(NSEvent *) event
	  fromButton:(NSButton *) button {
	if ([AMLocaleUtilities isCharacterForKeycode: event.keyCode]) {
		//NSLog(@"%@", event);
		NSArray *stringArray = [_model stringArrayForPlistKey: _currentPlist CharacterKey: button.title];
		[_popoverController showWindow: button withStringArray: stringArray];
	}
}

#pragma mark IBActions
- (IBAction) popUpButtonChanged:(NSPopUpButton *)sender {
	[self updateInputSource];
}

#pragma mark Other methods
- (void) resignKeyWindow {
	[_popoverController close];
//	[_keyboardController resetModifierKeyStates];
}

- (void) updateInputSource {
	_currentPlist = self.languagesPopUpButton.titleOfSelectedItem;
	
//	[_keyboardController rebuildKeyLayout];
}


@end
