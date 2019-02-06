//
//  BBaseLocationHandler.h
//  ChatSDK
//
//  Created by Pepe Becker on 24/01/2019.
//  Copyright © 2018 Pepe Becker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ChatSDK/PLocationHandler.h>

@class RXPromise;
@class CLLocationManagerDelegate;

@protocol LastLocationDelegate <NSObject>

- (void)didUpdateLastLocation:(CLLocation *)location;

@end

@interface BBaseLocationHandler : NSObject<LastLocationDelegate>

+ (BBaseLocationHandler *)shared;

- (BOOL)isUpdatingLocation;
- (void)startUpdatingLocation;
- (void)startUpdatingLocationWithInterval:(NSTimeInterval)interval;
- (void)stopUpdatingLocation;

- (CLLocation *)lastLocation;
- (RACSignal *)locationSignal;

- (void)setUpdateDistance:(long)meters;

@end
