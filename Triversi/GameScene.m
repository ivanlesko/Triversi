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
        
        self.game = [[Game alloc] init];
        self.game.board = self.board;
        
        // Place the initial pieces after the board has been created.
        [self.board placeInitialPieces];
        
        Scorezone *scorezone = [Scorezone createScorezoneAtPosition:CGPointMake(size.width / 2.0, size.height * 0.9)];
        [self addChild:scorezone];
        
        [self.game addScorezoneAsListener:scorezone];
        
        [self updatePlayerScores];
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
            if ([[self.board.playedPieces objectAtIndex:touchedPiece.row.integerValue] objectAtIndex:touchedPiece.column.integerValue] == [NSNull null]) {
                // Set the new triangles position to the triangle that was touched.
                position = [touch locationInNode:touchedPiece];
                if ([touchedPiece.touchableArea containsPoint:position]) {
                    
                    // Place a new piece at the given touch position.
                    [self placeNewPieceForTouched:touchedPiece];
                    
//                    NSArray *possibleMoves;
//                    if (self.game.turn == kTRTrianglePieceTypeRed) {
//                        possibleMoves =  [self indexesForTouchedIndex:[PieceIndex createPieceIndexWithRow:touchedPiece.row withColumn:touchedPiece.column]
//                                                        withDirection:touchedPiece.direction
//                                                             withType:kTRTrianglePieceTypeRed];
//                    } else {
//                        possibleMoves = [self indexesForTouchedIndex:[PieceIndex createPieceIndexWithRow:touchedPiece.row withColumn:touchedPiece.column]
//                                                       withDirection:touchedPiece.direction
//                                                            withType:kTRTrianglePieceTypeBlue];
//                    }
                    
//                    NSLog(@"turn: %d", self.game.turn);
//                    NSLog(@"possible moves: %d", possibleMoves.count);
//                    [self changeTurn];
                    
                }
            } else {
                // piece already exists.
            }
        }
    }
}

- (void)placeNewPieceForTouched:(Piece *)touchedPiece {
    NSArray *piecesToFlip;
    if (self.game.turn == kTRTrianglePieceTypeRed) {
        piecesToFlip =[self indexesForTouchedIndex:[PieceIndex createPieceIndexWithRow:touchedPiece.row withColumn:touchedPiece.column]
                                     withDirection:touchedPiece.direction
                                          withType:kTRTrianglePieceTypeRed];
        
    } else if (self.game.turn == kTRTrianglePieceTypeBlue) {
        piecesToFlip =  [self indexesForTouchedIndex:[PieceIndex createPieceIndexWithRow:touchedPiece.row withColumn:touchedPiece.column]
                                       withDirection:touchedPiece.direction
                                            withType:kTRTrianglePieceTypeBlue];
    }
    
    if (piecesToFlip.count > 0) {
        if (self.game.turn == kTRTrianglePieceTypeRed) {
            Piece *newPiece = [Piece placePieceAtRow:touchedPiece.row
                                           andColumn:touchedPiece.column
                                          atPosition:touchedPiece.position
                                       withPieceType:kTRTrianglePieceTypeRed
                                       withDirection:touchedPiece.direction
                                           withBoard:self.board];
            
        } else if (self.game.turn == kTRTrianglePieceTypeBlue) {
            Piece *newPiece = [Piece placePieceAtRow:touchedPiece.row
                                           andColumn:touchedPiece.column
                                          atPosition:touchedPiece.position
                                       withPieceType:kTRTrianglePieceTypeBlue
                                       withDirection:touchedPiece.direction
                                           withBoard:self.board];
        }
        
        for (PieceIndex *index in piecesToFlip) {
            if ([self pieceAtIndex:index.row Y:index.column]) {
                Piece *pieceToFlip = self.board.playedPieces[index.row.integerValue][index.column.integerValue];
                [pieceToFlip flipPiece];
            }
        }
        
        [self changeTurn];
        [self updatePlayerScores];
    }
}

#pragma mark - Move Logic

- (NSArray *)indexesForTouchedIndex:(PieceIndex *)index withDirection:(kTRTriangleDirection)direction withType:(kTRTrianglePieceType)type {
    NSMutableArray *indexes = [NSMutableArray array];
    NSMutableDictionary *tempIndexes = [NSMutableDictionary dictionary];
    
    NSArray *directions = [self directionsWithTriangleDirection:direction];
    
    for (int i = 0; i < directions.count; i++) {
        int traverseCount = 0;
        
        NSNumber *xDirection;
        NSNumber *yDirection;
        
        xDirection = [self xDirectionForTraverseCount:traverseCount andDirectionsArray:directions withDirectionIndex:i];
        yDirection = [self yDirectionForTraverseCount:traverseCount andDirectionsArray:directions withDirectionIndex:i];
        
        // Move x and y over 1 in the given direction.
        NSNumber *x = @(index.row.intValue + xDirection.intValue);
        NSNumber *y = @(index.column.intValue + yDirection.intValue);
        traverseCount++;
        
        // Make sure we are not checking out of bounds, has an adjacent piece, and is of a different color.
        if ([self isOnBoardX:x Y:y] && [self pieceExistsAtIndex:x Y:y] && [(Piece *)[self pieceAtIndex:x Y:y] type] != type) {
            
            // Reached the end of the board.
            if (![self isOnBoardX:x Y:y]) {
                continue;
            }
            
            // Keep traversing in the x and y direction as long as the next piece is the opponent's color.
            while ([self pieceExistsAtIndex:x Y:y] && [(Piece *)[self pieceAtIndex:x Y:y] type] != type) {
                
                xDirection = [self xDirectionForTraverseCount:traverseCount andDirectionsArray:directions withDirectionIndex:i];
                yDirection = [self yDirectionForTraverseCount:traverseCount andDirectionsArray:directions withDirectionIndex:i];
                
                x = [NSNumber numberWithInt:x.intValue + xDirection.intValue];
                y = [NSNumber numberWithInt:y.intValue + yDirection.intValue];
                traverseCount++;
                
                // Reached the end of the board.  Break out of the search.
                if (![self isOnBoardX:x Y:y]) {
                    break;
                }
                
                if (![self isOnBoardX:x Y:y] || ![self pieceExistsAtIndex:x Y:y]) {
                    continue;
                }
                
                /* By now we have found the last piece of the same color in the given direction */
                
                // If the last piece we traversed to is of the same type that we placed...
                if ([(Piece *)[self pieceAtIndex:x Y:y] type] == type) {
                    while (x != index.row || y != index.column) {
                        // Traverse backwards
                        if ([[[directions objectAtIndex:i] objectAtIndex:0] isKindOfClass:[NSArray class]]) {
                            if (!(traverseCount % 2 == 0)) {
                                xDirection = [[[directions objectAtIndex:i] objectAtIndex:0] objectAtIndex:0];
                                yDirection = [[[directions objectAtIndex:i] objectAtIndex:0] objectAtIndex:1];
                            } else {
                                xDirection = [[[directions objectAtIndex:i] objectAtIndex:1] objectAtIndex:0];
                                yDirection = [[[directions objectAtIndex:i] objectAtIndex:1] objectAtIndex:1];
                            }
                        }
                        
                        x = [NSNumber numberWithInt:x.intValue - xDirection.intValue];
                        y = [NSNumber numberWithInt:y.intValue - yDirection.intValue];
                        traverseCount--;
                        
                        if (x == index.row && y == index.column) {
                            break;
                        }
                        
                        // Create piece indexes for the given x and y values.
                        PieceIndex *index = [PieceIndex createPieceIndexWithRow:x withColumn:y];
                        if (![tempIndexes objectForKey:[NSString stringWithFormat:@"%@", index]]) {
                            [indexes addObject:index];
                        }
                        
                        [tempIndexes setObject:index forKey:[NSString stringWithFormat:@"%@", index]];
                        
                    }
                }
            }
        }
    }
    
    return indexes;
}

- (NSNumber *)xDirectionForTraverseCount:(int)traverseCount andDirectionsArray:(NSArray *)directions withDirectionIndex:(int)i {
    NSNumber *xDirection;
    if ([[[directions objectAtIndex:i] objectAtIndex:0] isKindOfClass:[NSArray class]]) {
        // The x and y direction depend on the traverse count.
        // If it is the first traverse, add by the first numbers in the direction array.
        // If it is the second traverse, add by the second numbers in the direction array.
        if (traverseCount % 2 == 0) {
            xDirection = [[[directions objectAtIndex:i] objectAtIndex:0] objectAtIndex:0];
        } else {
            xDirection = [[[directions objectAtIndex:i] objectAtIndex:1] objectAtIndex:0];
        }
    } else {
        xDirection = [[directions objectAtIndex:i] objectAtIndex:0];
    }
    
    return xDirection;
}

- (NSNumber *)yDirectionForTraverseCount:(int)traverseCount andDirectionsArray:(NSArray *)directions withDirectionIndex:(int)i {
    NSNumber *yDirection;
    if ([[[directions objectAtIndex:i] objectAtIndex:0] isKindOfClass:[NSArray class]]) {
        if (traverseCount % 2 == 0) {
            yDirection = [[[directions objectAtIndex:i] objectAtIndex:0] objectAtIndex:1];
        } else {
            yDirection = [[[directions objectAtIndex:i] objectAtIndex:1] objectAtIndex:1];
        }
    } else {
        yDirection = [[directions objectAtIndex:i] objectAtIndex:1];
    }
    
    return yDirection;
}

- (NSArray *)directionsWithTriangleDirection:(kTRTriangleDirection)direction {
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
    
    return @[east, west, northEast, southEast, southWest, northWest];
}

#pragma mark - Scoring Logic

- (void)updatePlayerScores {
    
    self.game.player1score = @(0);
    self.game.player2score = @(0);
    
    for (NSArray *row in self.board.playedPieces) {
        for (Piece *piece in row) {
            if ([piece isKindOfClass:[Piece class]]) {
                switch (piece.type) {
                    case kTRTrianglePieceTypeRed:
                        self.game.player1score = @(self.game.player1score.intValue + 1);
                        break;
                        
                    case kTRTrianglePieceTypeBlue:
                        self.game.player2score = @(self.game.player2score.intValue + 1);
                        break;
                        
                    case kTRTrianglePieceTypeNeutral:
                        // do nothing
                        break;
                }
            }
        }
    }
}

#pragma mark - Board Logic

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

- (id)pieceAtIndex:(NSNumber *)x Y:(NSNumber *)y {
    Piece *piece = self.board.playedPieces[x.integerValue][y.integerValue];
    return piece;
}

- (void)flipPiecesForIndexes:(NSArray *)indexes withNewPiece:(Piece *)newPiece {
    for (PieceIndex *index in [NSArray arrayWithArray:indexes]) {
        Piece *piece = self.board.playedPieces[index.row.integerValue][index.column.integerValue];
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

















