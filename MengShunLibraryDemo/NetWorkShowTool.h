//
//  NetWorkShowTool.h
//  TempDemo
//
//  Created by MS on 15/10/12.
//  Copyright © 2015年 孟顺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"

@interface NetWorkShowTool : NSObject


+ (void)showMessageWithStatus:(AFNetworkReachabilityStatus) status;



@end
