//
//  BBaseLocationHandler.m
//  ChatSDK
//
//  Created by Pepe Becker on 24/01/2019.
//  Copyright © 2018 Pepe Becker. All rights reserved.
//

#import "BBaseLocationHandler.h"

#import <CoreLocation/CoreLocation.h>
#import <RXPromise/RXPromise.h>
#import <ReactiveObjC/ReactiveObjC.h>

#pragma mark - LocationManagerDelegate

@interface LocationManagerDelegate : NSObject<CLLocationManagerDelegate> {
    RACSubject * _locationSubject;
    CLLocation * _lastLocation;
    id<LastLocationDelegate> _lastLocationDelegate;
}

- (RACSignal<CLLocation *> *)locationSignal;
- (CLLocation *)lastLocation;

@end

@implementation LocationManagerDelegate

- (instancetype)initWithLocationDelegate:(id<LastLocationDelegate>)delegate
{
    self = [super init];
    if (self) {
        _lastLocationDelegate = delegate;
        _locationSubject = [RACSubject new];
    }
    return self;
}

- (RACSignal<CLLocation *> *)locationSignal {
    return _locationSubject;
}

- (CLLocation *)lastLocation {
    return _lastLocation;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation * location = [locations lastObject];
    if (location == nil) return;
    if (_lastLocation != nil && [location distanceFromLocation:_lastLocation] < 10) {
        return;
    }
    _lastLocation = location;
    [_locationSubject sendNext:_lastLocation];
    if (_lastLocationDelegate && [_lastLocationDelegate respondsToSelector:@selector(didUpdateLastLocation:)]) {
        [_lastLocationDelegate didUpdateLastLocation:_lastLocation];
    }
}

@end

#pragma mark - BBaseLocationHandler

@interface BBaseLocationHandler() {
    CLLocationManager * _locationManager;
    LocationManagerDelegate * _locationManagerDelegate;
    CLLocation * _lastLocation;
    RACDisposable * _updateDisposable;
    long _updateDistance;
}
@end

@implementation BBaseLocationHandler

+ (BBaseLocationHandler *)shared {
    static BBaseLocationHandler * instance = nil;
    @synchronized(self) {
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationManagerDelegate = [[LocationManagerDelegate alloc] initWithLocationDelegate:self];
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = _locationManagerDelegate;
//        _updateDistance = 100;
    }
    return self;
}

- (BOOL)isUpdatingLocation {
    return _updateDisposable && !_updateDisposable.disposed;
}

- (CLLocation *)lastLocation {
    return _lastLocation;
}

- (RACSignal *)locationSignal {
    if (_locationManagerDelegate) {
        return _locationManagerDelegate.locationSignal;
    } else {
        return [RACSignal empty];
    }
}

- (void)startUpdatingLocation {
    [self startUpdatingLocationWithInterval:10];
}

- (void)startUpdatingLocationWithInterval:(NSTimeInterval)interval {
    [self stopUpdatingLocation];
    RACScheduler * scheduler = [RACScheduler mainThreadScheduler];
    RACSignal * intervalSignal = [RACSignal interval:interval onScheduler:scheduler];
    _updateDisposable = [intervalSignal subscribeNext:^(id x) {
        [self requestLocationUpdate];
    }];
}

- (void)stopUpdatingLocation {
    if (_updateDisposable) {
        [_updateDisposable dispose];
    }
    if (_locationManager) {
        [_locationManager stopUpdatingLocation];
    }
}

- (void)requestLocationUpdate {
    if (_locationManager) {
        [_locationManager startUpdatingLocation];
    }
}

- (void)setAccuracy:(CLLocationAccuracy)accuracy {
    if (_locationManager) {
        _locationManager.desiredAccuracy = accuracy;
    }
}

- (void)setUpdateDistance:(long)meters {
    if (meters) {
        _updateDistance = meters;
    } else {
        _updateDistance = 0;
    }
}

#pragma mark - LastLocationDelegate

- (void)didUpdateLastLocation:(CLLocation *)location {
    _lastLocation = location;
    if (_locationManager) {
        [_locationManager stopUpdatingLocation];
    }
}

@end
