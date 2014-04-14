//
//  Triangle.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "Triangle.h"

@implementation Triangle

+ (Triangle *)createTriangleAtPosition:(CGPoint)position upSideDown:(BOOL)upSideDown {
    Triangle *newTriangle = [Triangle node];
    newTriangle.position  = position;
    newTriangle.name = @"triangle";
    
    CGFloat sideLength = 55.0f;
    CGFloat height = sideLength * (sqrtf(3) / 2.0);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    if (upSideDown) {
        [path moveToPoint:CGPointMake(0, -height / 2.0)];
        [path addLineToPoint:CGPointMake(-sideLength / 2.0, height / 2.0)];
        [path addLineToPoint:CGPointMake(sideLength / 2.0, height / 2.0)];
        [path addLineToPoint:CGPointMake(0, -height / 2.0)];
        
        newTriangle.fillColor = [SKColor colorWithHexString:@"bd3b3b"];
    } else {
        [path moveToPoint:CGPointMake(0, height / 2.0)];
        [path addLineToPoint:CGPointMake(-sideLength / 2.0, -height / 2.0)];
        [path addLineToPoint:CGPointMake(sideLength / 2.0, -height / 2.0)];
        [path addLineToPoint:CGPointMake(0, height / 2.0)];
        
        newTriangle.fillColor = [SKColor colorWithHexString:@"395c78"];
    }
    newTriangle.antialiased = YES;
    newTriangle.path = path.CGPath;
    newTriangle.lineWidth = 0.0f;
    
    return newTriangle;
}

@end
