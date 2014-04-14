//
//  Triangle.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "TrianglePiece.h"

@implementation TrianglePiece

+ (TrianglePiece *)createTriangleAtPosition:(CGPoint)position withPieceType:(kTRTrianglePieceType)pieceType upSideDown:(BOOL)upSideDown {
    TrianglePiece *newTriangle = [TrianglePiece node];
    newTriangle.position  = position;
    newTriangle.name = @"triangle";
    newTriangle.type = pieceType;
    newTriangle.row  = 0;
    newTriangle.column = 0;
    
    CGFloat sideLength = 55.0f;
    CGFloat height = sideLength * (sqrtf(3) / 2.0);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    if (upSideDown) {
        [path moveToPoint:CGPointMake(0, -height / 2.0)];
        [path addLineToPoint:CGPointMake(-sideLength / 2.0, height / 2.0)];
        [path addLineToPoint:CGPointMake(sideLength / 2.0, height / 2.0)];
        [path addLineToPoint:CGPointMake(0, -height / 2.0)];
        newTriangle.fillColor = [SKColor colorWithHexString:@"395c78"];
    } else {
        [path moveToPoint:CGPointMake(0, height / 2.0)];
        [path addLineToPoint:CGPointMake(-sideLength / 2.0, -height / 2.0)];
        [path addLineToPoint:CGPointMake(sideLength / 2.0, -height / 2.0)];
        [path addLineToPoint:CGPointMake(0, height / 2.0)];
        newTriangle.fillColor = [SKColor colorWithHexString:@"bd3b3b"];
    }
    
    switch (pieceType) {
        case kTRTrianglePieceTypeNeutral:
            newTriangle.fillColor = [SKColor lightGrayColor];
            break;
            
        case kTRTrianglePieceTypeBlue:
            break;
            
        case kTRTrianglePieceTypeRed:
            break;
    }
    
    newTriangle.touchableArea = path;
    newTriangle.antialiased = YES;
    newTriangle.path = path.CGPath;
    
    newTriangle.lineWidth = 0.0f;
    
    return newTriangle;
}

@end
