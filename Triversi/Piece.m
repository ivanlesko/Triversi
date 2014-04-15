//
//  Triangle.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "Piece.h"

@implementation Piece

+ (Piece *)placePieceAtRow:(int)row
                 andColumn:(int)column
                atPosition:(CGPoint)position
             withPieceType:(kTRTrianglePieceType)pieceType
             withDirection:(kTRTriangleDirection)direction
                  withName:(NSString *)name
{
    Piece *newPiece = [Piece node];
    newPiece.position  = position;
    newPiece.name = name;
    newPiece.type = pieceType;
    newPiece.direction = direction;
    newPiece.row  = row;
    newPiece.column = column;
    
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
    
    newPiece.touchableArea = path;
    newPiece.antialiased = YES;
    newPiece.path = path.CGPath;
    
    switch (pieceType) {
        case kTRTrianglePieceTypeNeutral:
            newPiece.fillColor = [SKColor lightGrayColor];
            break;
            
        case kTRTrianglePieceTypeRed:
            newPiece.fillColor = [SKColor colorWithHexString:@"bd3b3b"];
            break;
            
        case kTRTrianglePieceTypeBlue:
            newPiece.fillColor = [SKColor colorWithHexString:@"395c78"];
            break;
    }
    
    newPiece.lineWidth = 0.0f;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PLACED_NEW_PIECE object:newPiece];
    
    return newPiece;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Piece type: %d direction: %d row: %d column: %d", self.type, self.direction, self.row, self.column];
}

@end












