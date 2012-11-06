//
//  PIGAppDelegate.h
//  CleanTask
//
//  Created by loki tang on 12-11-5.
//  Copyright (c) 2012年 loki tang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PIGSettings.h"

@interface PIGAppDelegate : NSObject <NSApplicationDelegate> {
    NSStatusItem *appStatusItem;
    NSOpenPanel *targetDirectoryDialog;
    
    NSString *storageDirectory;
    
    PIGSettings *pigSettings;
    
    NSNotificationCenter *center;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSButton *intervalChekcBox;
@property (weak) IBOutlet NSTextField *intervalInputTextfield;
@property (weak) IBOutlet NSButton *openDirectoryButton;
@property (weak) IBOutlet NSTextField *checkIntervalTextField;
@property (weak) IBOutlet NSButton *classifyButton;

@end
