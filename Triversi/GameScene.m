//
//  GameScene.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "GameScene.h"
#import "Piece.h"

@implementation GameScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.board = [Board createNewBoardAtPosition:CGPointMake(size.width / 2.0, size.height / 2.0)];
        [self addChild:self.board];
        [self.board placeInitialPieces];
        
        self.game = [[Game alloc] init];
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInNode:self];
    NSArray *nodes = [self nodesAtPoint:position];
    for (Piece *touchedPiece in nodes) {
        // Touched an empty space.
        if ([touchedPiece isKindOfClass:[Piece class]]) {
            // If a piece does not exist in this spot, add one.
            if ([[self.board.playedPieces objectAtIndex:touchedPiece.row] objectAtIndex:touchedPiece.column] == [NSNull null]) {
                // Set the new triangles position to the triangle that was touched.
                position = [touch locationInNode:touchedPiece];
                if ([touchedPiece.touchableArea containsPoint:position]) {
                    // Determine corner case logic based on whether the new triangle is facing up or down.
                    if ([self legalMove:touchedPiece]) {
                        Piece *newPiece = [Piece placePieceAtRow:touchedPiece.row
                                                       andColumn:touchedPiece.column
                                                      atPosition:touchedPiece.position
                                                   withPieceType:self.game.turn ? kTRTrianglePieceTypeBlue : kTRTrianglePieceTypeRed
                                                   withDirection:touchedPiece.direction
                                                       withBoard:self.board];
                        
                        [self flipPiecesForIndexes:[self piecesToFlipForNewPiece:newPiece] withNewPiece:newPiece];
                        
                        [self changeTurn];
                    }
                }
            } else {
                // piece already exists.
            }
        }
    }
}

- (BOOL)legalMove:(Piece *)touchedPiece {
    for (PieceIndex *index in touchedPiece.adjacentPieces) {
        // Grab a pointer to the touched pieces adjacent pieces.
        Piece *piece = [[self.board.playedPieces objectAtIndex:index.row] objectAtIndex:index.column];
        // If there is an adjacent piece, check and make sure it is not a nil class, then allow a move to be made.
        if ([piece isKindOfClass:[Piece class]]) {
            return YES;
        }
    }
    
    return NO;
}

- (NSArray *)piecesToFlipForNewPiece:(Piece *)newPiece {
    NSMutableArray *pieces = [NSMutableArray array];
    NSArray *east, *west, *northEast, *southEast, *northWest, *southWest;
    
    east = @[@0, @1];
    west = @[@0, @-1];

    // Set the directions based on the triangle's direction.
    if (newPiece.direction == kTRTriangleDirectionUp) {
        northEast = @[
                      @[@1, @0],
                      @[@0, @-1]
                      ];
        
        southEast = @[
                      @[@0, @1],
                      @[@1, @0]
                      ];
        
        southWest = @[
                      @[@0, @1],
                      @[@-1, @0]
                      ];
        
        northWest = @[
                      @[@-1, @0],
                      @[@0, @-1]
                      ];
        
    } else {
        // Triangle facing down.
        northEast = @[
                      @[@0, @-1],
                      @[@1, @0]
                      ];
        
        southEast = @[
                      @[@1, @0],
                      @[@0, @1]
                      ];
        
        southWest = @[
                      @[@-1, @0],
                      @[@0, @1]
                      ];
        
        northWest = @[
                      @[@0, @-1],
                      @[@-1, @0]
                      ];
    }
    
    NSArray *directions = @[east, west];
    
    NSNumber *xDirection;
    NSNumber *yDirection;
    
    for (int i = 0; i < directions.count; i++) {
        xDirection = [[directions objectAtIndex:i] objectAtIndex:0];
        yDirection = [[directions objectAtIndex:i] objectAtIndex:1];
        
        NSNumber *x = [NSNumber numberWithInt:newPiece.row + xDirection.intValue];
        NSNumber *y = [NSNumber numberWithInt:newPiece.column + yDirection.intValue];
        
        // Make sure we are not checking out of bounds and the first piece we check is an opponent's piece.
        if ([self isOnBoardX:x Y:y] && [self pieceExistsAtIndex:x Y:y] && [(Piece *)[self pieceAtIndex:x Y:y] type] != newPiece.type) {
            // There is a piece that belongs to the opponent next to our piece
            x = [NSNumber numberWithInt:x.intValue + xDirection.intValue];
            y = [NSNumber numberWithInt:y.intValue + yDirection.intValue];
            
            // If we are out of the bounds of the board, continue to the next direction
            if (![self isOnBoardX:x Y:y]) {
                continue;
            }
            
            // Keep traversion in the x and y direction as long as the next piece is the opponent's color.
            while ([(Piece *)[self pieceAtIndex:x Y:y] type] != newPiece.type) {
                x = [NSNumber numberWithInt:x.intValue + xDirection.intValue];
                y = [NSNumber numberWithInt:y.intValue + yDirection.intValue];
                
                
                // If we are out of bounds, break to the next direction
                if (![self isOnBoardX:x Y:y]) {
                    break;
                }
            }
            
            if (![self isOnBoardX:x Y:y]) {
                continue;
            }
            
            // If the last piece we traversed to is of the same type that we placed...
            if ([(Piece *)[self pieceAtIndex:x Y:y] type] == newPiece.type) {
                while (x.integerValue != newPiece.row || y.integerValue != newPiece.column) {
                    // Traverse backwards
                    x = [NSNumber numberWithInt:x.intValue - xDirection.intValue];
                    y = [NSNumber numberWithInt:y.intValue - yDirection.intValue];
                    
                    if (x.integerValue == newPiece.row && y.integerValue == newPiece.column) {
                        break;
                    }
                    
                    PieceIndex *index = [PieceIndex createPieceIndexWithRow:x.integerValue withColumn:y.integerValue];
                    [pieces addObject:index];
                }
            }
        }
    }
    
    NSLog(@"%@", pieces);
    
    return pieces;
}

- (BOOL)isOnBoardX:(NSNumber *)x Y:(NSNumber *)y {
    if (x.intValue < COLUMNS && x.intValue >= 0 && y.intValue < ROWS && y.intValue >= 0) {
        return TRUE;
    }
    
    return FALSE;
}

- (BOOL)pieceExistsAtIndex:(NSNumber *)x Y:(NSNumber *)y {
    if (self.board.playedPieces[x.integerValue][y.integerValue] != NULL_OBJECT) {
        return TRUE;
    }
    
    return FALSE;
}

- (Piece *)pieceAtIndex:(NSNumber *)x Y:(NSNumber *)y {
    Piece *piece = self.board.playedPieces[x.integerValue][y.integerValue];
    return piece;
}

- (void)flipPiecesForIndexes:(NSArray *)indexes withNewPiece:(Piece *)newPiece {
    for (PieceIndex *index in [NSArray arrayWithArray:indexes]) {
        Piece *piece = self.board.playedPieces[index.row][index.column];
        [piece flipPiece];
    }
}


- (void)changeTurn {
    if (self.game.turn == kTRPieceColorPlayer1) {
        self.game.turn = kTRPieceColorPlayer2;
    } else {
        self.game.turn = kTRPieceColorPlayer1;
    }
}

@end

















