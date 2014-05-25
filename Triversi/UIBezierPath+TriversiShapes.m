//
//  UIBezierPath+TriversiShapes.m
//  Triversi
//
//  Created by Luda on 5/25/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "UIBezierPath+TriversiShapes.h"

@implementation UIBezierPath (TriversiShapes)

+ (UIBezierPath *)acuteTriangleForDirection:(kTRTriangleDirection)direction {
    ////// Path Creation //////
    
    // Set the size of the piece depending on what device the user is on.
    CGFloat sideLength;
    if ([UIDevice iPhone]) {
        sideLength = 320.0f / 5.8181f;
    }
    
    if ([UIDevice iPad]) {
        sideLength = 768.0f / 6.8181f;
    }
    
    CGFloat height = sideLength * (sqrtf(3) / 2.0);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // Set the direction of the piece depending on the up/down enum.
    switch (direction) {
        case kTRTriangleDirectionUp:
            [path moveToPoint:CGPointMake(0, height / 2.0)];
            [path addLineToPoint:CGPointMake(-sideLength / 2.0, -height / 2.0)];
            [path addLineToPoint:CGPointMake(sideLength / 2.0, -height / 2.0)];
            [path addLineToPoint:CGPointMake(0, height / 2.0)];
            break;
            
        case kTRTriangleDirectionDown:
            [path moveToPoint:CGPointMake(0, -height / 2.0)];
            [path addLineToPoint:CGPointMake(-sideLength / 2.0, height / 2.0)];
            [path addLineToPoint:CGPointMake(sideLength / 2.0, height / 2.0)];
            [path addLineToPoint:CGPointMake(0, -height / 2.0)];
            break;
    }
    
    return path;
}

@end
