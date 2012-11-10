//
//  PIGClassifyDesktopUtil.h
//  CleanTask
//
//  Created by loki on 12-11-10.
//  Copyright (c) 2012年 loki tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PIGSettings.h"

@interface PIGClassifyDesktopUtil : NSObject {
    PIGSettings *settings;
    NSFileManager *manager;
}

- (void) initTargetDirectory:(PIGSettings *)value;
- (void) performPackage;

@end
