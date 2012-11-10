//
//  PIGClassifyDesktopUtil.h
//  CleanTask
//
//  Created by loki on 12-11-10.
//  Copyright (c) 2012年 loki tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/xattr.h>
#import "PIGSettings.h"

@interface PIGClassifyDesktopUtil : NSObject {
    PIGSettings *settings;
    NSFileManager *manager;
    
    NSObject *settingSource;
    
    NSString *homePath;
    NSString *desktopPath;
    
    NSString *moveToDirectory;
}

- (void) initTargetDirectory:(PIGSettings *)value;
- (void) performPackage;

@end
