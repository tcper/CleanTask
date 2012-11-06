//
//  PIGAppDelegate.m
//  CleanTask
//
//  Created by loki tang on 12-11-5.
//  Copyright (c) 2012年 loki tang. All rights reserved.
//

#import "PIGAppDelegate.h"

@implementation PIGAppDelegate

@synthesize window;
@synthesize openDirectoryButton;

@synthesize checkIntervalTextField;
@synthesize intervalChekcBox;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    pigSettings = [[PIGSettings alloc] init];
}

- (void)awakeFromNib {
    appStatusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    NSImage *appStatusItemIcon = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon_16" ofType:@"png"]];
    [appStatusItem setImage:appStatusItemIcon];
    [appStatusItem setAction:@selector(statusItemClickAction)];

    [window setReleasedWhenClosed:NO];
    
}

- (void) statusItemClickAction {
    NSLog(@"click,%d", [window isVisible]);
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
            NSString *openDirectoryButtonTitle;
            if ([storageDirectory length] > 25) {
                openDirectoryButtonTitle = [storageDirectory substringToIndex:25];
                openDirectoryButtonTitle = [openDirectoryButtonTitle stringByAppendingString:@"..."];
            } else {
                openDirectoryButtonTitle = storageDirectory;
            }
            [openDirectoryButton setTitle:openDirectoryButtonTitle];
            if (storageDirectory != lastStorageDirectory) {
                [pigSettings changeSettings:DESKTOP_STORAGE_DIR value:storageDirectory];
            }
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
        [checkIntervalTextField setEnabled:YES];
        //[pigSettings changeSettings:IS_PERIODICAL value:YES];
    } else {
        [checkIntervalTextField setEnabled:NO];
        //[pigSettings changeSettings:IS_PERIODICAL value:NO];
    }
}

@end
