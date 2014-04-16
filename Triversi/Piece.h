//
//  Triangle.h
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Board.h"

@class Board;

@interface Piece : SKShapeNode

@property (nonatomic) UIBezierPath *touchableArea;
@property (nonatomic) kTRTrianglePieceType type;
@property (nonatomic) kTRTriangleDirection direction;
@property (nonatomic) int row;
@property (nonatomic) int column;

/// Each piece knows about its adjacent pieces
@property (nonatomic, strong) NSMutableArray *adjacentPieces;

/// Every piece belongs to a board.
@property (nonatomic, weak) Board *board;

/// Places a new piece on the board with a given row, column, position, type, and direction.
+ (Piece *)placePieceAtRow:(int)row
                 andColumn:(int)column
                atPosition:(CGPoint)position
             withPieceType:(kTRTrianglePieceType)pieceType
             withDirection:(kTRTriangleDirection)direction;

@end
