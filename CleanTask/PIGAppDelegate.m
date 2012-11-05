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

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
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
    dialog = [NSOpenPanel openPanel];
    [dialog setCanChooseDirectories:YES];
    [dialog setCanChooseFiles:NO];
    [dialog setPrompt:@"Select Your Directory:"];
}
- (IBAction)classifyButtonAction:(id)sender {
}
- (IBAction)immediateCleanAction:(id)sender {
}

@end
