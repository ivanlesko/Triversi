//
//  Triangle.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "Piece.h"

@implementation Piece

+ (Piece *)placePieceAtRow:(NSInteger)row
                 andColumn:(NSInteger)column
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
    newPiece.adjacentPieces = [NSMutableArray array];

    // Set the left piece if it is not on the left edge.
    if (newPiece.column > 0) {
        newPiece.leftPiece = [PieceIndex createPieceIndexWithRow:newPiece.row withColumn:newPiece.column - 1];
        [newPiece.adjacentPieces addObject:newPiece.leftPiece];
    } 
    
    // Set the right piece, if it is not on the right edge.
    if (newPiece.column < COLUMNS - 1) {
        newPiece.rightPiece = [PieceIndex createPieceIndexWithRow:newPiece.row withColumn:newPiece.column + 1];
        [newPiece.adjacentPieces addObject:newPiece.rightPiece];
    }

    if (newPiece.direction == kTRTriangleDirectionUp) {
        // has a bottomPiece
        if (newPiece.row < ROWS - 1) {
            newPiece.bottomPiece = [PieceIndex createPieceIndexWithRow:newPiece.row + 1 withColumn:newPiece.column];
            [newPiece.adjacentPieces addObject:newPiece.bottomPiece];
        }
    } else {
        // has a topPiece
        if (newPiece.row > 0) {
            newPiece.topPiece = [PieceIndex createPieceIndexWithRow:newPiece.row - 1 withColumn:newPiece.column];
            [newPiece.adjacentPieces addObject:newPiece.topPiece];
        }
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
    
    newPiece.lineWidth = 0.25f;
    
    // Post a notification that a new piece has been placed on the board.
    [[NSNotificationCenter defaultCenter] postNotificationName:PLACED_NEW_PIECE object:newPiece];
    
    return newPiece;
}

- (void)flipPiece {
    switch (self.type) {
        case kTRTrianglePieceTypeBlue:
            self.type = kTRTrianglePieceTypeRed;
            self.fillColor = [SKColor colorWithHexString:@"bd3b3b"];
            break;
            
        case kTRTrianglePieceTypeRed:
            self.type = kTRTrianglePieceTypeBlue;
            self.fillColor = [SKColor colorWithHexString:@"395c78"];
            break;
            
        case kTRTrianglePieceTypeNeutral:
            // do nothing
            break;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"\nPiece #(%d, %d)\ntype: %d\ndirection: %d\nleft adjacent: %@\nright adjacent: %@\ntop adjacent: %@\nbottom adjacent: %@\n",
            self.row,
            self.column,
            self.type,
            self.direction,
            self.leftPiece,
            self.rightPiece,
            self.topPiece,
            self.bottomPiece];
}

@end












