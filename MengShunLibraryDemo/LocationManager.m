//
//  LocationManager.m
//  LocationDemo
//
//  Created by MS on 15/10/27.
//  Copyright © 2015年 孟顺. All rights reserved.
//

#import "LocationManager.h"
#import <objc/runtime.h>


#define timeout 30.0

@interface LocationManager ()<CLLocationManagerDelegate>{
    CLLocationManager *_locationManager;
    int _haveQuestCount;
}
@end

@implementation LocationManager


static LocationManager *_obj = nil;
- (instancetype)init{

    @synchronized(self){
        if (!_obj) {
            _obj = [super init];
        }
        return _obj;
    }
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized(self){
        if (!_obj) {
            _obj = [[super allocWithZone:nil]init];
        }
        return _obj;
    }
}



- (void)geocodeAddressString:(NSString *)addressString completionHandle:(CLLocationBlock) block{
    
    if (addressString == nil || [addressString isKindOfClass:[NSNull class]] || [addressString length] == 0) {
        block(nil);
        return;
    }
    
    __block BOOL isHaveTimeOut = YES;
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, timeout*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        if (isHaveTimeOut) {
            block(nil);
        }
    });
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:addressString completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        isHaveTimeOut = NO;
        CLPlacemark *placePark = [placemarks firstObject];
        CLLocation *location = placePark.location;
        if ([placemarks isKindOfClass:[NSNull class]] || location == nil) {
            block(nil);
        } else {
            block(location);
        }
    }];
    
}


bool currentAddressTimeOut = YES;
- (void)currentAddressComletion:(AddressComletionBlock)block{
    
    if ([CLLocationManager locationServicesEnabled]) {
        _haveQuestCount = 0;
        //需要在info.plist 里面添加 NSLocationWhenInUseUsageDescription string 值可以为空
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = kCLHeadingFilterNone;
        _locationManager.delegate = self;
        [_locationManager requestWhenInUseAuthorization];
        objc_setAssociatedObject(_locationManager, @"AddressComletionBlock", block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [_locationManager startUpdatingLocation];

        
        
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, timeout*NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            if (currentAddressTimeOut) {
                block(nil);
            }
        });
        
        
    } else {
        block(nil);
    }
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    currentAddressTimeOut = NO;
    [manager stopUpdatingLocation];
    manager.delegate = nil;
    
    if (_haveQuestCount == 0) {
        _haveQuestCount++;
        CLLocation *location = [locations lastObject];
        CLGeocoder *geocoder = [[CLGeocoder alloc]init];
        
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *park = [placemarks firstObject];
            NSDictionary *cityMessage = park.addressDictionary;
            AddressComletionBlock block = objc_getAssociatedObject(manager, @"AddressComletionBlock");
            if (block) {
                block(cityMessage);
                objc_removeAssociatedObjects(manager);
            }
        }];
    }
    
    
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    currentAddressTimeOut = NO;
    
    if ([error domain] == kCLErrorDomain) {
        switch ([error code]) {
            case kCLErrorLocationUnknown:
                NSLog(@"location is currently unknown, but CL will keep trying");
                break;
            case kCLErrorDenied:
                NSLog(@"Access to location or ranging has been denied by the user");
                break;
            case kCLErrorNetwork:
                NSLog(@"general, network-related error");
                break;
            case kCLErrorHeadingFailure:
                NSLog(@"heading could not be determined");
                break;
            case kCLErrorRegionMonitoringDenied:
                NSLog(@"Location region monitoring has been denied by the user");
                break;
            case kCLErrorRegionMonitoringFailure:
                NSLog(@"A registered region cannot be monitored");
                break;
            case kCLErrorRegionMonitoringSetupDelayed:
                NSLog(@"CL could not immediately initialize region monitoring");
                break;
            case kCLErrorRegionMonitoringResponseDelayed:
                NSLog(@"While events for this fence will be delivered, delivery will not occur immediately");
                break;
            case kCLErrorGeocodeFoundNoResult:
                NSLog(@"A geocode request yielded no result");
                break;
            case kCLErrorGeocodeFoundPartialResult:
                NSLog(@"A geocode request yielded a partial result");
                break;
            case kCLErrorGeocodeCanceled:
                NSLog(@"A geocode request was cancelled");
                break;
            case kCLErrorDeferredFailed:
                NSLog(@"Deferred mode failed");
                break;
            case kCLErrorDeferredNotUpdatingLocation:
                NSLog(@"Deferred mode failed because location updates disabled or paused");
                break;
            case kCLErrorDeferredAccuracyTooLow:
                NSLog(@"Deferred mode not supported for the requested accuracy");
                break;
            case kCLErrorDeferredDistanceFiltered:
                NSLog(@"Deferred mode does not support distance filters");
                break;
            case kCLErrorDeferredCanceled:
                NSLog(@"Deferred mode request canceled a previous request");
                break;
            case kCLErrorRangingUnavailable:
                NSLog(@"Ranging cannot be performed");
                break;
            case kCLErrorRangingFailure:
                NSLog(@"General ranging failure");
                break;
            default:
                break;
        }
    }
    
 
    AddressComletionBlock block = objc_getAssociatedObject(manager, @"AddressComletionBlock");
    if (block) {
        block(nil);
        objc_removeAssociatedObjects(manager);
    } else {
        NSLog(@"Block is nil");
    }

}

@end
