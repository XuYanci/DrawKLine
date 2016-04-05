//
//  JDNavigationController.m
//  JustDrawIt
//
//  Created by Yanci on 16/4/2.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "JDNavigationController.h"

@implementation JDNavigationController

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.orientation;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation != self.orientation);
}

@end
