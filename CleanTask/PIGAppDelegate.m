//
//  PIGAppDelegate.m
//  CleanTask
//
//  Created by loki tang on 12-11-5.
//  Copyright (c) 2012年 loki tang. All rights reserved.
//

#import "PIGAppDelegate.h"
#import "PIGLaunchItemUtil.h"

@implementation PIGAppDelegate

@synthesize window;
@synthesize openDirectoryButton;

@synthesize checkIntervalTextField;
@synthesize intervalChekcBox;
@synthesize classifyButton;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    pigSettings = [[PIGSettings alloc] init];
    
    [self updateDirectoryButton];
    [self updatePeriodicalCheckbox];
}

- (void)awakeFromNib {
    center = [NSNotificationCenter defaultCenter];
    
    appStatusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    NSImage *appStatusItemIcon = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_16x16" ofType:@"png"]];
    [appStatusItem setImage:appStatusItemIcon];
    [appStatusItem setAction:@selector(statusItemClickAction)];
    [classifyButton setEnabled:NO];

    [window setReleasedWhenClosed:NO];
}

- (void) statusItemClickAction {
    if ([window isVisible]) {
        [window orderOut:self];
    } else {
        [window makeKeyAndOrderFront:self];
        [NSApp activateIgnoringOtherApps:YES];
    }
}
- (IBAction)directorySettingButtonAction:(id)sender {
    targetDirectoryDialog = [NSOpenPanel openPanel];
    [targetDirectoryDialog setCanChooseDirectories:YES];
    [targetDirectoryDialog setCanChooseFiles:NO];
    [targetDirectoryDialog setAllowsMultipleSelection:NO];

    NSString *lastStorageDirectory = (NSString *)[pigSettings getSetting:DESKTOP_STORAGE_DIR];
    [targetDirectoryDialog setDirectoryURL:[NSURL fileURLWithPath:lastStorageDirectory]];

    [targetDirectoryDialog setPrompt:@"Select Your Directory"];
    [targetDirectoryDialog beginSheetModalForWindow:window completionHandler:^(NSInteger returnCode){
        if(returnCode == NSOKButton){
            NSLog(@"%@", [[[targetDirectoryDialog URLs] objectAtIndex:0] path]);
            storageDirectory = [[[targetDirectoryDialog URLs] objectAtIndex:0] path];
            if (storageDirectory != lastStorageDirectory) {
                [pigSettings changeStorageDirectory:storageDirectory];
            }
            
            [self updateDirectoryButton];
        }
    }];
}
- (IBAction)classifyButtonAction:(id)sender {
}
- (IBAction)immediateCleanAction:(id)sender {
    //clean function
    [pigSettings updateCleanTime];
}
- (IBAction)isPeriodicalCheck:(id)sender {
    if ([intervalChekcBox state] == NSOnState) {
        [pigSettings changePeriodical:YES];
    } else {
        [pigSettings changePeriodical:NO];
    }
    [self updateIntervalTextfieldCheck];
}
- (IBAction)loginLaunchAction:(id)sender {
    NSButton *button = (NSButton *)sender;
    if ([button state] == NSOnState) {
        [PIGLaunchItemUtil launchAtLogin:YES];
    } else {
        [PIGLaunchItemUtil launchAtLogin:NO];
    }
}

- (void) updateDirectoryButton {
    NSString *storageDirectoryString = (NSString *)[pigSettings getSetting:DESKTOP_STORAGE_DIR];
    if ([storageDirectoryString length] > 25) {
        storageDirectoryString = [storageDirectoryString substringToIndex:25];
        storageDirectoryString = [storageDirectoryString stringByAppendingString:@"..."];
    }
    
    [openDirectoryButton setTitle:storageDirectoryString];
}

- (void) updatePeriodicalCheckbox {
    BOOL isPeriodical = [(NSNumber *)[pigSettings getSetting:IS_PERIODICAL] boolValue];
    if (isPeriodical) {
        [intervalChekcBox setState:NSOnState];
    } else {
        [intervalChekcBox setState:NSOffState];
    }
    [self updateIntervalTextfieldCheck];
}

- (void) updateIntervalTextfieldCheck {
    if ([intervalChekcBox state] == NSOnState) {
        [checkIntervalTextField setEnabled:YES];
    } else {
        [checkIntervalTextField setEnabled:NO];
    }
}

@end
