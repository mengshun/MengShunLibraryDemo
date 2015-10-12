//
//  NetWorkShowTool.m
//  TempDemo
//
//  Created by MS on 15/10/12.
//  Copyright © 2015年 孟顺. All rights reserved.
//

#import "NetWorkShowTool.h"
#import <UIKit/UIKit.h>

@implementation NetWorkShowTool{
    
}

+ (void)showMessageWithStatus:(AFNetworkReachabilityStatus) status{
    UIWindow *keyWindow = [UIApplication sharedApplication].windows[0];
    if (keyWindow) {
        
        UILabel *messageLable = [[UILabel alloc]init];
        messageLable.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
        messageLable.layer.cornerRadius = 3;
        messageLable.layer.masksToBounds = YES;
        messageLable.translatesAutoresizingMaskIntoConstraints = NO;
        messageLable.textAlignment = NSTextAlignmentCenter;
        messageLable.font = [UIFont systemFontOfSize:17];
        messageLable.textColor = [UIColor whiteColor];
        [keyWindow addSubview:messageLable];
        
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                NSLog(@"网络状态未知");
                messageLable.text = @" 网络状态未知 ";
                
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"无法连接网络");
                messageLable.text = @" 无法连接网络 ";
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                NSLog(@"检测到 3G");
                messageLable.text = @" 检测到 3G ";
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"检测到 wifi");
                messageLable.text = @" 检测到 wifi ";
            }
                break;
                
            default:
                break;
        }

        
        [keyWindow addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[messageLable(>=0)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(messageLable)]];
        
        [keyWindow addConstraint:[NSLayoutConstraint constraintWithItem:messageLable attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:keyWindow attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [keyWindow addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[messageLable(25)]-80-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(messageLable)]];
        
        
        double delayInSeconds = 1.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [UIView animateWithDuration:0.5 animations:^{
                messageLable.alpha = 0;
            } completion:^(BOOL finished) {
                [messageLable removeFromSuperview];
            }];
            
        });
        
    }
}

@end
