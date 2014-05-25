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

/**
 *  A Piece object is a view object that also contains the data information about a given piece.
 *  It draws itself and contains information about itself such as its coordinates on the board.
 *  Pieces can only be "placed" on a board using the @p placePieceAtRow:@p method.
 *
 
 @code
 Piece *newPiece = [Piece placePieceAtRow:touchedPiece.row
                                andColumn:touchedPiece.column
                               atPosition:touchedPiece.position
                            withPieceType:kTRTrianglePieceTypeBlue
                            withDirection:touchedPiece.direction
                                withBoard:self.board];
 @endcode
 */
@interface Piece : SKSpriteNode

@property (nonatomic, strong) UIBezierPath *touchableArea;
@property (nonatomic) kTRTrianglePieceType type;
@property (nonatomic) kTRTriangleDirection direction;
@property (nonatomic) NSNumber *row;
@property (nonatomic) NSNumber *column;

/// Every piece belongs to a board.
@property (nonatomic, strong) Board *board;

/**
 *  The piece's neighbor's.  Will contain either one or two other pieces, depending if it is on an edge or not.
 */
@property (nonatomic, strong) NSMutableArray *adjacentPieces;
@property (nonatomic) PieceIndex *leftPiece;
@property (nonatomic) PieceIndex *rightPiece;
@property (nonatomic) PieceIndex *topPiece;
@property (nonatomic) PieceIndex *bottomPiece;

/**
 *  Places a new pieces on the board.
 *
 *  @param row       the x coordinate (NSNumber)
 *  @param column    the y coordinate (NSNumber)
 *  @param position  the pieces position in its parent's coordinate system (CGPoint)
 *  @param pieceType player1, player2, or neutral
 *  @param direction up or down
 *  @param board     the board the pieces resides on
 *
 *  @return A new piece
 */
+ (Piece *)placePieceAtRow:(NSNumber *)row
            andColumn:(NSNumber *)column
           atPosition:(CGPoint)position
        withPieceType:(kTRTrianglePieceType)pieceType
        withDirection:(kTRTriangleDirection)direction
            withBoard:(Board *)board;

- (void)flipPiece;

@end
