NSDictionary* prefs;

%hook SBLockScreenManager

//
// This function is called when the iPhone is unlocked...
//

- (void)_finishUIUnlockFromSource:(int)source withOptions:(id)options {
	%orig;

	//
	// Check if the enabled key in the settings file is a truthy value...
	//

	if ([prefs[@"enabled"] boolValue]) {

		// Create a UIAlertView object...
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
														message:@"Tweak has been enabled"
													   delegate:nil
											  cancelButtonTitle:@"Okay"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];

	}
}

%end



//
// Loads the preferences from the plist file.
//

void loadPreferences() {
	// File path to the preferences plist file...
	NSString* settingsPlistFilePath = @"/var/mobile/Library/Preferences/com.tapsharp.sampletweaksettings.plist";

	// Load the preferences as a NSDictionary object...
	prefs = [NSDictionary dictionaryWithContentsOfFile:settingsPlistFilePath];
}



//
// NOTE: Constructor is called first before anything else.
//

%ctor {

	// Add an observer. This listens for changes made in the preferences panel and then reloads the "loadPreferences" function as a
	// callback. So basically, this works as an observer that registers a function to be called everytime the preferences switches
	// are changed.

	CFNotificationCenterAddObserver(
		CFNotificationCenterGetDarwinNotifyCenter(),
		NULL,
		(CFNotificationCallback) loadPreferences, // <-- Here we specified our function above as the callback function to be called everytime the preferences file is changed
		(CFStringRef) @"com.tapsharp.sampletweaksettings/ReloadPrefs", // <-- Here we register a unique notification key, this MUST match the PostNotification value in the preference bundles plist
		NULL,
		CFNotificationSuspensionBehaviorCoalesce
	);

	// Load the preferences manually.
	loadPreferences();

	// Initialize our tweak hooks.
	%init;
}
