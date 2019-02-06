//
//  BLocationHandler.h
//  ChatSDK
//
//  Created by Pepe Becker on 24/01/2019.
//  Copyright © 2018 Pepe Becker. All rights reserved.
//

#ifndef PLocationHandler_h
#define PLocationHandler_h

@class RACSignal;
@class CLLocation;
@class NSInterval;

@protocol PLocationHandler <NSObject>

- (RACSignal *)locationSignal;
- (CLLocation *)lastLocation;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;
- (BOOL)isUpdatingLocation;

- (void)setUpdateInterval:(NSInterval *)interval;
- (void)setUpdateDistance:(int)meters;

- (NSInterval *)updateInterval;
- (int)updateDistance;

@end

#endif /* PLocationHandler_h */
