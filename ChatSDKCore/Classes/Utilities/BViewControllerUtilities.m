//
//  BViewControllerUtilities.m
//  ChatSDK
//
//  Created by Pepe Becker on 01/04/2019.
//

#import "BViewControllerUtilities.h"

@implementation BViewControllerUtilities

+ (void)popOrDimissViewController:(UIViewController *)controller animated:(BOOL)animated {
    if ([self isRootInNavigationViewController:controller]) {
        [controller dismissViewControllerAnimated:animated completion:nil];
    } else {
        [controller.navigationController popViewControllerAnimated:animated];
    }
}

+ (BOOL)isRootInNavigationViewController:(UIViewController *)controller {
    UINavigationController * navController = controller.navigationController;
    if (!navController) return YES;
    UIViewController * rootController = [[navController viewControllers] firstObject];
    if (!rootController) return YES;
    return [rootController isEqual:controller];
}

@end
