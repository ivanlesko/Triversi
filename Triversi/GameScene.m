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
                    
                    NSArray *piecesToFlip = [self indexesForTouchedIndex:[PieceIndex createPieceIndexWithRow:touchedPiece.row withColumn:touchedPiece.column] withDirection:touchedPiece.direction];

                    NSLog(@"%@", piecesToFlip);
                    
                    [self changeTurn];
                }
            } else {
                // piece already exists.
            }
        }
    }
}

- (NSArray *)piecesToFlipForIndex:(PieceIndex *)newPiece withType:(kTRTrianglePieceType)type withDirection:(kTRTriangleDirection)direction {
    NSMutableArray *pieces = [NSMutableArray array];
    NSArray *east, *west, *northEast, *southEast, *northWest, *southWest;
    
    east = @[@0, @1];
    west = @[@0, @-1];

    // Set the directions based on the triangle's direction.
    if (direction == kTRTriangleDirectionUp) {
        northEast = @[
                      @[@0, @1],
                      @[@-1, @0]
                      ];
        
        southEast = @[
                      @[@1, @0],
                      @[@0, @1]
                      ];
        
        southWest = @[
                      @[@1, @0],
                      @[@0, @-1]
                      ];
        
        northWest = @[
                      @[@0, @-1],
                      @[@-1, @0]
                      ];
        
    } else {
        // Triangle facing down.
        northEast = @[
                      @[@-1, @0],
                      @[@0, @1]
                      ];
        
        southEast = @[
                      @[@0, @1],
                      @[@1, @0]
                      ];
        
        southWest = @[
                      @[@0, @-1],
                      @[@1, @0]
                      ];
        
        northWest = @[
                      @[@-1, @0],
                      @[@0, @-1]
                      ];
    }
    
    NSArray *directions = @[east, west];
    
    NSNumber *xDirection;
    NSNumber *yDirection;
    
    
    for (int i = 0; i < directions.count; i++) {
        int traverseCount = 0;
        
        xDirection = [[directions objectAtIndex:i] objectAtIndex:0];
        yDirection = [[directions objectAtIndex:i] objectAtIndex:1];
        
        NSNumber *x = [NSNumber numberWithInt:newPiece.row + xDirection.intValue];
        NSNumber *y = [NSNumber numberWithInt:newPiece.column + yDirection.intValue];
        
        // Make sure we are not checking out of bounds and the first piece we check is an opponent's piece.
        if ([self isOnBoardX:x Y:y] && [self pieceExistsAtIndex:x Y:y] && [(Piece *)[self pieceAtIndex:x Y:y] type] != type) {
            x = [NSNumber numberWithInt:x.intValue + xDirection.intValue];
            y = [NSNumber numberWithInt:y.intValue + yDirection.intValue];
            // There is a piece that belongs to the opponent next to our piece
            
            // If we are out of the bounds of the board, continue to the next direction
            if (![self isOnBoardX:x Y:y]) {
                continue;
            }
            
            // Keep traversing in the x and y direction as long as the next piece is the opponent's color.
            while ([(Piece *)[self pieceAtIndex:x Y:y] type] != type) {
                x = [NSNumber numberWithInt:x.intValue + xDirection.intValue];
                y = [NSNumber numberWithInt:y.intValue + yDirection.intValue];
                
                // If we are out of bounds, break to the next direction
                if (![self isOnBoardX:x Y:y] || self.board.playedPieces[x.integerValue][y.integerValue] == NULL_OBJECT) {
                    break;
                }
            }
            
            if (![self isOnBoardX:x Y:y] || self.board.playedPieces[x.integerValue][y.integerValue] == NULL_OBJECT) {
                continue;
            }
            
            // If the last piece we traversed to is of the same type that we placed...
            if ([(Piece *)[self pieceAtIndex:x Y:y] type] == type) {
                while (x.integerValue != newPiece.row || y.integerValue != newPiece.column) {
                    // Traverse backwards
                    x = [NSNumber numberWithInt:x.intValue - xDirection.intValue];
                    y = [NSNumber numberWithInt:y.intValue - yDirection.intValue];
                    
                    if (x.integerValue == newPiece.row && y.integerValue == newPiece.column) {
                        break;
                    }
                    
                    // Create piece indexes for the given x and y values.
                    PieceIndex *index = [PieceIndex createPieceIndexWithRow:x.integerValue withColumn:y.integerValue];
                    [pieces addObject:index];
                }
            }
        }
    }
    
    return pieces;
}

- (NSArray *)indexesForTouchedIndex:(PieceIndex *)index withDirection:(kTRTriangleDirection)direction {
    NSMutableArray *indexes = [NSMutableArray array];
    NSArray *east, *west, *northEast, *southEast, *northWest, *southWest;
    
    east = @[@0, @1];
    west = @[@0, @-1];
    
    // Set the directions based on the triangle's direction.
    if (direction == kTRTriangleDirectionUp) {
        northEast = @[
                      @[@0, @1],
                      @[@-1, @0]
                      ];
        
        southEast = @[
                      @[@1, @0],
                      @[@0, @1]
                      ];
        
        southWest = @[
                      @[@1, @0],
                      @[@0, @-1]
                      ];
        
        northWest = @[
                      @[@0, @-1],
                      @[@-1, @0]
                      ];
        
    } else {
        // Triangle facing down.
        northEast = @[
                      @[@-1, @0],
                      @[@0, @1]
                      ];
        
        southEast = @[
                      @[@0, @1],
                      @[@1, @0]
                      ];
        
        southWest = @[
                      @[@0, @-1],
                      @[@1, @0]
                      ];
        
        northWest = @[
                      @[@-1, @0],
                      @[@0, @-1]
                      ];
    }
    
    NSArray *directions = @[east, west, northEast, southEast, southWest, northWest];
    
    NSNumber *xDirection;
    NSNumber *yDirection;
    
    for (int i = 0; i < directions.count; i++) {
        int traverseCount = 0;
        if ([[[directions objectAtIndex:i] objectAtIndex:0] isKindOfClass:[NSArray class]]) {
            // The x and y direction depend on the traverse count.
            // If it is the first traverse, add by the first numbers in the direction array.
            // If it is the second traverse, add by the second numbers in the direction array.
            if (traverseCount % 2 == 0) {
                xDirection = [[[directions objectAtIndex:i] objectAtIndex:0] objectAtIndex:0];
                yDirection = [[[directions objectAtIndex:i] objectAtIndex:0] objectAtIndex:1];
            } else {
                xDirection = [[[directions objectAtIndex:i] objectAtIndex:1] objectAtIndex:0];
                yDirection = [[[directions objectAtIndex:i] objectAtIndex:1] objectAtIndex:1];
            }
        } else {
            xDirection = [[directions objectAtIndex:i] objectAtIndex:0];
            yDirection = [[directions objectAtIndex:i] objectAtIndex:1];
        }
        
        // Move x and y over 1 in the given direction.
        NSNumber *x = [NSNumber numberWithInt:index.row + xDirection.intValue];
        NSNumber *y = [NSNumber numberWithInt:index.column + yDirection.intValue];
        traverseCount++;
        
        // Make sure we are not checking out of bounds.
        if ([self isOnBoardX:x Y:y]) {
            if ([[[directions objectAtIndex:i] objectAtIndex:0] isKindOfClass:[NSArray class]]) {
                if (traverseCount % 2 == 0) {
                    xDirection = [[[directions objectAtIndex:i] objectAtIndex:0] objectAtIndex:0];
                    yDirection = [[[directions objectAtIndex:i] objectAtIndex:0] objectAtIndex:1];
                } else {
                    xDirection = [[[directions objectAtIndex:i] objectAtIndex:1] objectAtIndex:0];
                    yDirection = [[[directions objectAtIndex:i] objectAtIndex:1] objectAtIndex:1];
                }
            }
            
            x = [NSNumber numberWithInt:x.intValue + xDirection.intValue];
            y = [NSNumber numberWithInt:y.intValue + yDirection.intValue];
            traverseCount++;
            
            // Reached the end of the board.
            if (![self isOnBoardX:x Y:y]) {
                continue;
            }
            
            // Keep traversing in the x and y direction until we hit the end of the board.
            while ([self isOnBoardX:x Y:y]) {
                if ([[[directions objectAtIndex:i] objectAtIndex:0] isKindOfClass:[NSArray class]]) {
                    if (traverseCount % 2 == 0) {
                        xDirection = [[[directions objectAtIndex:i] objectAtIndex:0] objectAtIndex:0];
                        yDirection = [[[directions objectAtIndex:i] objectAtIndex:0] objectAtIndex:1];
                    } else {
                        xDirection = [[[directions objectAtIndex:i] objectAtIndex:1] objectAtIndex:0];
                        yDirection = [[[directions objectAtIndex:i] objectAtIndex:1] objectAtIndex:1];
                    }
                }
                
                x = [NSNumber numberWithInt:x.intValue + xDirection.intValue];
                y = [NSNumber numberWithInt:y.intValue + yDirection.intValue];
                traverseCount++;
                
                // Reached the end of the board.  Break out of the search.
                if (![self isOnBoardX:x Y:y]) {
                    break;
                }
                
                PieceIndex *index = [PieceIndex createPieceIndexWithRow:x.integerValue withColumn:y.integerValue];
                [indexes addObject:index];
            }
        }
    }
    
    return indexes;
}

- (BOOL)isOnBoardX:(NSNumber *)x Y:(NSNumber *)y {
    if (x.intValue < ROWS && x.intValue >= 0 && y.intValue < COLUMNS && y.intValue >= 0) {
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
    if (self.game.turn == kTRTrianglePieceTypeRed) {
        self.game.turn = kTRTrianglePieceTypeBlue;
    } else {
        self.game.turn = kTRTrianglePieceTypeRed;
    }
}

@end

















