//
//  LocationManager.h
//  LocationDemo
//
//  Created by MS on 15/10/27.
//  Copyright © 2015年 孟顺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


typedef void(^CLLocationBlock)(CLLocation *location);
typedef void(^AddressComletionBlock)(NSDictionary *dictionary);

@interface LocationManager : NSObject

- (void)geocodeAddressString:(NSString *)addressString completionHandle:(CLLocationBlock) blcok;

- (void)currentAddressComletion:(AddressComletionBlock)block;

@end
