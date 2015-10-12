//
//  GlobalData.h
//  MengShunLibraryDemo
//
//  Created by MS on 15/8/27.
//  Copyright (c) 2015年 孟顺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalData : NSObject

+ (instancetype)shareInstance;

@property (nonatomic,assign) BOOL isFirstEnterApp;




@end
