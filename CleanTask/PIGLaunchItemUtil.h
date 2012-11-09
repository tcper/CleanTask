//
//  PIGLaunchItemUtil.h
//  CleanTask
//
//  Created by loki tang on 12-11-7.
//  Copyright (c) 2012年 loki tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PIGLaunchItemUtil : NSObject

extern NSString * const APP_IDENTIFIER;

+ (void) launchAtLogin: (BOOL) value;
+ (BOOL) checkIsAddedLoginItem;
@end
