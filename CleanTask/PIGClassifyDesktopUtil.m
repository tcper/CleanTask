//
//  PIGClassifyDesktopUtil.m
//  CleanTask
//
//  Created by loki on 12-11-10.
//  Copyright (c) 2012年 loki tang. All rights reserved.
//

#import "PIGClassifyDesktopUtil.h"

@implementation PIGClassifyDesktopUtil

- (id) init {
    manager = [NSFileManager defaultManager];
    return self;
}

- (void) initTargetDirectory:(PIGSettings *) value{
    settings = value;
    
    NSString *targetDirectoryPath = (NSString *) [settings getSetting:DESKTOP_STORAGE_DIR];
    if ([manager fileExistsAtPath:targetDirectoryPath]) {
        NSLog(@"PIGClassifyDesktopUtil storage dir exists, do nothing");
    } else {
        [manager createDirectoryAtPath:targetDirectoryPath withIntermediateDirectories:NO attributes:nil error:NULL];
    }
}

- (void) performPackage {
    
}

@end
