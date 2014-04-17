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
                 withBoard:(Board *)board
{
    Piece *newPiece = [Piece node];
    newPiece.position  = position;
    newPiece.type = pieceType;
    newPiece.direction = direction;
    newPiece.row  = row;
    newPiece.column = column;
    newPiece.board = board;

    
    // Set the left piece if it is not on the left edge.
    if (newPiece.column != 0) {
        newPiece.leftPiece.row = newPiece.row;
        newPiece.leftPiece.column = newPiece.column - 1;
    } else {
        newPiece.leftPiece = nil;
    }
    
    // Set the right piece, if it is not on the right edge.
    if (newPiece.column != COLUMNS) {
        newPiece.rightPiece.row = newPiece.row;
        newPiece.rightPiece.column = newPiece.column + 1;
    } else {
        newPiece.rightPiece = nil;
    }
    
    if (pieceType == kTRTrianglePieceTypeNeutral) {
        newPiece.name = [NSString stringWithFormat:@"placeholder_%d%d", newPiece.row, newPiece.column];
    } else {
        newPiece.name = [NSString stringWithFormat:@"piece_%d%d", newPiece.row, newPiece.column];
    }
    
    // Set the size of the piece depending on what device the user is on.
    CGFloat sideLength;
    if ([UIDevice iPhone]) {
        sideLength = 320.0f / 5.8181f;
    }
    
    if ([UIDevice iPad]) {
        sideLength = 768.0f / 5.8181f;
    }
    
    CGFloat height = sideLength * (sqrtf(3) / 2.0);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // Set the direction of the piece depending on the up/down enum.
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
    
    newPiece.path = path.CGPath;
    newPiece.touchableArea = path;
    newPiece.antialiased = YES;
    
    // Set the piece's color based on the pieceType enum.;
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
    
    // Post a notification that a new piece has been placed on the board.
    [[NSNotificationCenter defaultCenter] postNotificationName:PLACED_NEW_PIECE object:newPiece];
    
    return newPiece;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Piece type: %d direction: %d row: %d column: %d", self.type, self.direction, self.row, self.column];
}

@end












