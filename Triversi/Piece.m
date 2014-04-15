//
//  Triangle.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "Piece.h"

@implementation Piece

+ (Piece *)createPieceAtPosition:(CGPoint)position withPieceType:(kTRTrianglePieceType)pieceType withDirection:(kTRTriangleDirection)direction
{
    Piece *newTriangle = [Piece node];
    newTriangle.position  = position;
    newTriangle.name = @"triangle";
    newTriangle.type = pieceType;
    newTriangle.row  = 0;
    newTriangle.column = 0;
    
    CGFloat sideLength = 55.0f;
    CGFloat height = sideLength * (sqrtf(3) / 2.0);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    switch (direction) {
        case kTRTriangleDirectionDown:
            [path moveToPoint:CGPointMake(0, -height / 2.0)];
            [path addLineToPoint:CGPointMake(-sideLength / 2.0, height / 2.0)];
            [path addLineToPoint:CGPointMake(sideLength / 2.0, height / 2.0)];
            [path addLineToPoint:CGPointMake(0, -height / 2.0)];
            break;
            
        case kTRTriangleDirectionUp:
            [path moveToPoint:CGPointMake(0, height / 2.0)];
            [path addLineToPoint:CGPointMake(-sideLength / 2.0, -height / 2.0)];
            [path addLineToPoint:CGPointMake(sideLength / 2.0, -height / 2.0)];
            [path addLineToPoint:CGPointMake(0, height / 2.0)];
            break;
    }
    
    switch (pieceType) {
        case kTRTrianglePieceTypeNeutral:
            newTriangle.fillColor = [SKColor lightGrayColor];
            break;
            
        case kTRTrianglePieceTypeRed:
            newTriangle.fillColor = [SKColor colorWithHexString:@"395c78"];
            break;
            
        case kTRTrianglePieceTypeBlue:
            newTriangle.fillColor = [SKColor colorWithHexString:@"bd3b3b"];
            break;
    }
    
    newTriangle.touchableArea = path;
    newTriangle.antialiased = YES;
    newTriangle.path = path.CGPath;
    
    newTriangle.lineWidth = 0.0f;
    
    return newTriangle;
}

+ (Piece *)placePieceAtRow:(int)row
                 andColumn:(int)column
                atPosition:(CGPoint)position
             withPieceType:(kTRTrianglePieceType)pieceType
             withDirection:(kTRTriangleDirection)direction;
{
    Piece *newTriangle = [Piece node];
    newTriangle.position  = position;
    newTriangle.name = @"piece";
    newTriangle.type = pieceType;
    newTriangle.row  = row;
    newTriangle.column = column;
    
    CGFloat sideLength = 55.0f;
    CGFloat height = sideLength * (sqrtf(3) / 2.0);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    switch (direction) {
        case kTRTriangleDirectionDown:
            [path moveToPoint:CGPointMake(0, -height / 2.0)];
            [path addLineToPoint:CGPointMake(-sideLength / 2.0, height / 2.0)];
            [path addLineToPoint:CGPointMake(sideLength / 2.0, height / 2.0)];
            [path addLineToPoint:CGPointMake(0, -height / 2.0)];
            break;
            
        case kTRTriangleDirectionUp:
            [path moveToPoint:CGPointMake(0, height / 2.0)];
            [path addLineToPoint:CGPointMake(-sideLength / 2.0, -height / 2.0)];
            [path addLineToPoint:CGPointMake(sideLength / 2.0, -height / 2.0)];
            [path addLineToPoint:CGPointMake(0, height / 2.0)];
            break;
    }
    
    switch (pieceType) {
        case kTRTrianglePieceTypeNeutral:
            newTriangle.fillColor = [SKColor lightGrayColor];
            break;
            
        case kTRTrianglePieceTypeRed:
            newTriangle.fillColor = [SKColor colorWithHexString:@"bd3b3b"];
            break;
            
        case kTRTrianglePieceTypeBlue:
            newTriangle.fillColor = [SKColor colorWithHexString:@"395c78"];
            break;
    }
    
    newTriangle.touchableArea = path;
    newTriangle.antialiased = YES;
    newTriangle.path = path.CGPath;
    
    newTriangle.lineWidth = 0.0f;
    
    return newTriangle;
}

@end












