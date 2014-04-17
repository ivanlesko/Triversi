//
//  Triangle.h
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Board.h"
#import "PieceIndex.h"

@class Board;

@interface Piece : SKShapeNode

@property (nonatomic) UIBezierPath *touchableArea;
@property (nonatomic) kTRTrianglePieceType type;
@property (nonatomic) kTRTriangleDirection direction;
@property (nonatomic) NSInteger row;
@property (nonatomic) NSInteger column;

/// Every piece belongs to a board.
@property (nonatomic, weak) Board *board;

@property (nonatomic) PieceIndex *leftPiece;
@property (nonatomic) PieceIndex *rightPiece;

/// Places a new piece on the board with a given row, column, position, type, and direction.
+ (id)placePieceAtRow:(NSInteger)row
            andColumn:(NSInteger)column
           atPosition:(CGPoint)position
        withPieceType:(kTRTrianglePieceType)pieceType
        withDirection:(kTRTriangleDirection)direction
            withBoard:(Board *)board;

@end
