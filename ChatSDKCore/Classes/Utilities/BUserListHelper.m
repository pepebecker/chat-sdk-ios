//
//  BUserListHelper.m
//  ChatSDK
//
//  Created by Pepe Becker on 01/04/2019.
//

#import "BUserListHelper.h"

#import <ChatSDK/Core.h>

@implementation BUserListHelper

+ (id<PUser>)getUserFromList:(NSArray<id<PUser>> *)list byEntityID:(NSString *)entityID {
    if (!list || list.count <= 0 || !entityID || entityID.length <= 0) return nil;
    for (id<PUser> user in list) {
        if ([user.entityID isEqualToString:entityID]) {
            return user;
        }
    }
    return nil;
}

+ (NSArray<id<PUser>> *)addUser:(id<PUser>)user toList:(NSArray<id<PUser>> *)list {
    if (!user) return [list copy];
    id<PUser> existingUser = [self getUserFromList:list byEntityID:user.entityID];
    if (existingUser) return [list copy];
    if (!list) return @[user];
    NSMutableArray<id<PUser>> * mutableList = [list mutableCopy];
    [mutableList addObject:user];
    return mutableList;
}

+ (NSArray<id<PUser>> *)removeUserFromList:(NSArray<id<PUser>> *)list byEntityID:(NSString *)entityID {
    if (!list) return [NSArray new];
    if (list.count <= 0 || !entityID || entityID.length <= 0) return [list copy];
    id<PUser> existingUser = [self getUserFromList:list byEntityID:entityID];
    NSMutableArray * mutableList = [list mutableCopy];
    [mutableList removeObject:existingUser];
    return mutableList;
}

@end
