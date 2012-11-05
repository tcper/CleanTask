//
//  PIGAppDelegate.h
//  CleanTask
//
//  Created by loki tang on 12-11-5.
//  Copyright (c) 2012年 loki tang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PIGAppDelegate : NSObject <NSApplicationDelegate> {
    NSStatusItem *appStatusItem;
    NSOpenPanel *dialog;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSButton *intervalChekcBox;
@property (weak) IBOutlet NSTextField *intervalInputTextfield;

@end
