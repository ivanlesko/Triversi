//
//  UIDevice+DeviceCheck.m
//  Triversi
//
//  Created by Luda on 4/16/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "UIDevice+DeviceCheck.h"

@implementation UIDevice (DeviceCheck)

- (BOOL)iPhone {
    return (self.userInterfaceIdiom == UIUserInterfaceIdiomPhone);
}
+ (BOOL)iPhone {
    return [[UIDevice currentDevice] iPhone];
}

- (BOOL)iPad {
    return (self.userInterfaceIdiom == UIUserInterfaceIdiomPad);
}
+ (BOOL)iPad {
    return [[UIDevice currentDevice] iPad];
}

@end
