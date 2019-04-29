//
//  BUserListHelper.h
//  ChatSDK
//
//  Created by Pepe Becker on 01/04/2019.
//

#import <Foundation/Foundation.h>
#import <ChatSDK/PUser.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUserListHelper : NSObject

+ (id<PUser>)getUserFromList:(NSArray<id<PUser>> *)list byEntityID:(NSString *)entityID;
+ (NSArray<id<PUser>> *)addUser:(id<PUser>)user toList:(NSArray<id<PUser>> *)list;
+ (NSArray<id<PUser>> *)removeUserFromList:(NSArray<id<PUser>> *)list byEntityID:(NSString *)entityID;

@end

NS_ASSUME_NONNULL_END
