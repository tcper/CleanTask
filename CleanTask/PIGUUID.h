//
//  PIGUUID.h
//  CleanTask
//
//  Created by loki tang on 12-11-13.
//  Copyright (c) 2012年 loki tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PIGUUID : NSObject <NSConnectionDelegate>
+ (NSString *) UUIDString;
- (void) survey;
@end
