//
//  Triangle.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "Piece.h"
#import "TextureStore.h"

@implementation Piece

+ (Piece *)placePieceAtRow:(NSNumber *)row
                 andColumn:(NSNumber *)column
                atPosition:(CGPoint)position
             withPieceType:(kTRTrianglePieceType)pieceType
             withDirection:(kTRTriangleDirection)direction
                 withBoard:(Board *)board
{
    Piece *newPiece = [TextureStore createPieceWithPieceType:pieceType
                                        withDirection:direction];
    
    NSLog(@"new piece class: %@", [newPiece class]);
    newPiece.position  = position;
    newPiece.row  = row;
    newPiece.column = column;
    newPiece.board = board;
    newPiece.adjacentPieces = [NSMutableArray array];

    // Set the left piece if it is not on the left edge.
    if (newPiece.column > 0) {
        newPiece.leftPiece = [PieceIndex createPieceIndexWithRow:newPiece.row withColumn:@(newPiece.column.intValue - 1)];
        [newPiece.adjacentPieces addObject:newPiece.leftPiece];
    } 
    
    // Set the right piece, if it is not on the right edge.
    if (newPiece.column.intValue < COLUMNS - 1) {
        newPiece.rightPiece = [PieceIndex createPieceIndexWithRow:newPiece.row withColumn:@(newPiece.column.intValue + 1)];
        [newPiece.adjacentPieces addObject:newPiece.rightPiece];
    }

    if (newPiece.direction == kTRTriangleDirectionUp) {
        // has a bottomPiece
        if (newPiece.row.intValue < ROWS - 1) {
            newPiece.bottomPiece = [PieceIndex createPieceIndexWithRow:@(newPiece.row.intValue + 1) withColumn:newPiece.column];
            [newPiece.adjacentPieces addObject:newPiece.bottomPiece];
        }
    } else {
        // has a topPiece
        if (newPiece.row > 0) {
            newPiece.topPiece = [PieceIndex createPieceIndexWithRow:@(newPiece.row.intValue - 1) withColumn:newPiece.column];
            [newPiece.adjacentPieces addObject:newPiece.topPiece];
        }
    }
    
    if (pieceType == kTRTrianglePieceTypeNeutral) {
        newPiece.name = [NSString stringWithFormat:@"placeholder_%@%@", newPiece.row, newPiece.column];
    } else {
        newPiece.name = [NSString stringWithFormat:@"piece_%@%@", newPiece.row, newPiece.column];
    }
    
    // Post a notification that a new piece has been placed on the board.
    [[NSNotificationCenter defaultCenter] postNotificationName:PLACED_NEW_PIECE object:newPiece];
    
    return newPiece;
}

- (void)flipPiece {
    switch (self.type) {
        case kTRTrianglePieceTypeBlue:
            self.type = kTRTrianglePieceTypeRed;
//            self.fillColor = [SKColor colorWithHexString:@"bd3b3b"];
            break;
            
        case kTRTrianglePieceTypeRed:
            self.type = kTRTrianglePieceTypeBlue;
//            self.fillColor = [SKColor colorWithHexString:@"395c78"];
            break;
            
        case kTRTrianglePieceTypeNeutral:
            // do nothing
            break;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"\nPiece #(%ld,%ldd)\ntype: %d\ndirection: %d\nleft adjacent: %@\nright adjacent: %@\ntop adjacent: %@\nbottom adjacent: %@\n",
            (long)self.row,
            (long)self.column,
            self.type,
            self.direction,
            self.leftPiece,
            self.rightPiece,
            self.topPiece,
            self.bottomPiece];
}

@end












