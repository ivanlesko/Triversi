//
//  Triangle.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "Piece.h"
#import "TextureStore.h"
#import "UIBezierPath+TriversiShapes.h"

@implementation Piece

+ (Piece *)placePieceAtRow:(NSNumber *)row
                 andColumn:(NSNumber *)column
                atPosition:(CGPoint)position
             withPieceType:(kTRTrianglePieceType)pieceType
             withDirection:(kTRTriangleDirection)direction
                 withBoard:(Board *)board
{
    Piece *newPiece;
    
    // Up facing player 1 piece
    if (pieceType == kTRTrianglePieceTypeRed && direction == kTRTriangleDirectionUp) {
        newPiece = [Piece spriteNodeWithTexture:[[TextureStore sharedInstance] player1Up]];
    }
    
    // Down facing player 1 piece
    if (pieceType == kTRTrianglePieceTypeRed && direction == kTRTriangleDirectionDown) {
        newPiece = [Piece spriteNodeWithTexture:[[TextureStore sharedInstance] player1Down]];
    }
    
    // Up facing player 2 piece
    if (pieceType == kTRTrianglePieceTypeBlue && direction == kTRTriangleDirectionUp) {
        newPiece = [Piece spriteNodeWithTexture:[[TextureStore sharedInstance] player2Up]];
    }
    
    // Down facing player 2 piece
    if (pieceType == kTRTrianglePieceTypeBlue && direction == kTRTriangleDirectionDown) {
        newPiece = [Piece spriteNodeWithTexture:[[TextureStore sharedInstance] player2Down]];
    }
    
    // Up facing neutral piece
    if (pieceType == kTRTrianglePieceTypeNeutral && direction == kTRTriangleDirectionUp) {
        newPiece = [Piece spriteNodeWithTexture:[[TextureStore sharedInstance] neutralUp]];
    }
    
    // Down facing neutral piece
    if (pieceType == kTRTrianglePieceTypeNeutral && direction == kTRTriangleDirectionDown) {
        newPiece = [Piece spriteNodeWithTexture:[[TextureStore sharedInstance] neutralDown]];
    }
    
    newPiece.position  = position;
    newPiece.row  = row;
    newPiece.column = column;
    newPiece.board = board;
    newPiece.adjacentPieces = [NSMutableArray array];
    newPiece.direction = direction;
    newPiece.type = pieceType;
    newPiece.touchableArea = [UIBezierPath acuteTriangleForDirection:newPiece.direction];

    // Set the left piece if it is not on the left edge.
    if (newPiece.column.intValue > 0) {
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
        if (newPiece.row.intValue > 0) {
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

/**
 *  @todo the texture changing is not complete yet.
 */
- (void)flipPiece {
    switch (self.type) {
        case kTRTrianglePieceTypeBlue:
            if (self.direction == kTRTriangleDirectionUp) {
                self.texture = [[TextureStore sharedInstance] player1Up];
            } else {
                self.texture = [[TextureStore sharedInstance] player1Down];
            }
            
            self.type = kTRTrianglePieceTypeRed;
            break;
            
        case kTRTrianglePieceTypeRed:
            self.type = kTRTrianglePieceTypeBlue;
            if (self.direction == kTRTriangleDirectionUp) {
                self.texture = [[TextureStore sharedInstance] player2Up];
            } else {
                self.texture = [[TextureStore sharedInstance] player2Down];
            }
            
            self.type = kTRTrianglePieceTypeBlue;
            break;
            
        case kTRTrianglePieceTypeNeutral:
            // do nothing
            break;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"\nPiece #(%@,%@)\ntype: %d\ndirection: %d\nleft adjacent: %@\nright adjacent: %@\ntop adjacent: %@\nbottom adjacent: %@\n\n ",
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












