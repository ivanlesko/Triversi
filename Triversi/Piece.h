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

@property (nonatomic, strong) UIBezierPath *touchableArea;
@property (nonatomic) kTRTrianglePieceType type;
@property (nonatomic) kTRTriangleDirection direction;
@property (nonatomic) NSNumber *row;
@property (nonatomic) NSNumber *column;

/// Every piece belongs to a board.
@property (nonatomic, strong) Board *board;

@property (nonatomic, strong) NSMutableArray *adjacentPieces;
@property (nonatomic) PieceIndex *leftPiece;
@property (nonatomic) PieceIndex *rightPiece;
@property (nonatomic) PieceIndex *topPiece;
@property (nonatomic) PieceIndex *bottomPiece;

/// Creates a new piece but does not place it on the board.
/// This method is mostly used to create the textures for the documents directory.
+ (id)createPieceWithPieceType:(kTRTrianglePieceType)pieceType
                 withDirection:(kTRTriangleDirection)direction;

/// Places a new piece on the board with a given row, column, position, type, and direction.
+ (id)placePieceAtRow:(NSNumber *)row
            andColumn:(NSNumber *)column
           atPosition:(CGPoint)position
        withPieceType:(kTRTrianglePieceType)pieceType
        withDirection:(kTRTriangleDirection)direction
            withBoard:(Board *)board;

- (void)flipPiece;

@end
