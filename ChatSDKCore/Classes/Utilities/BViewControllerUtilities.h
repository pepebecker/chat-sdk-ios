//
//  BViewControllerUtilities.h
//  ChatSDK
//
//  Created by Pepe Becker on 01/04/2019.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BViewControllerUtilities : NSObject

+ (void)popOrDimissViewController:(UIViewController *)controller animated:(BOOL)animated;
+ (BOOL)isRootInNavigationViewController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
