//
//  PIGAppDelegate.h
//  CleanTask
//
//  Created by loki tang on 12-11-5.
//  Copyright (c) 2012年 loki tang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PIGSettings.h"
#import "PIGClassifyDesktopUtil.h"
#import "PIGLaunchItemUtil.h"

@interface PIGAppDelegate : NSObject <NSApplicationDelegate> {
    NSStatusItem *appStatusItem;
    NSOpenPanel *targetDirectoryDialog;
    
    NSString *storageDirectory;
    
    PIGSettings *pigSettings;
    PIGClassifyDesktopUtil *packageUtil;
    
    NSNotificationCenter *center;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSButton *intervalChekcBox;

@property (weak) IBOutlet NSButton *openDirectoryButton;

@property (weak) IBOutlet NSButton *classifyButton;
@property (weak) IBOutlet NSComboBox *intervalCombo;

@end
