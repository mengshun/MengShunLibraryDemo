//
//  GlobalData.m
//  MengShunLibraryDemo
//
//  Created by MS on 15/8/27.
//  Copyright (c) 2015年 孟顺. All rights reserved.
//

#import "GlobalData.h"

@implementation GlobalData

static GlobalData *obj = nil;
+ (instancetype)shareInstance{
    @synchronized(self){
        if (!obj) {
            obj = [[super alloc]init];
        }
        return obj;
    }
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized(self){
        if (!obj) {
            obj = [[super allocWithZone:zone]init];
        }
        return obj;
    }
}

- (instancetype)copy{
    return obj;
}

- (instancetype)mutableCopy{
    return obj;
}


- (BOOL)isFirstEnterApp{
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HAVE_ENTER_APP"]) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"HAVE_ENTER_APP"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        return YES;
    } else {
        return NO;
    }
    
    
}




@end
