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
                        
                        NSArray *piecesToFlip = [self piecesToFlipForNewPiece:newPiece];
                        
                        NSInteger xStart;
                        NSInteger yStart;
                        
                        
                        
//                        for (int i = 0; i < directions.count; i++) {
//                            xStart = newPiece.row;
//                            yStart = newPiece.column;
//                            NSInteger x = [[[directions objectAtIndex:i] objectAtIndex:0] integerValue];
//                            NSInteger y = [[[directions objectAtIndex:i] objectAtIndex:1] integerValue];
//                            NSLog(@"x: %d, y: %d", x, y);
//                            
//                        }
                        
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
    
    int east[2] = {1, 0};
    int west[2] = {-1, 0};
    
    int northEast[2][2];
    int southEast[2][2];
    int southWest[2][2];
    int northWest[2][2];
    switch (newPiece.direction) {
        case kTRTriangleDirectionUp:
            
            break;
            
        case kTRTriangleDirectionDown:
            northEast = {
                {0, 1},
                {1, 0}
            };
            
            southEast = {
                {1, 0},
                {0, 1}
            };
            
            
            
            break;
    }
    
    return pieces;
}

- (void)flipPiecesWithPlacedPiece:(Piece *)newPiece {
    for (PieceIndex *index in newPiece.adjacentPieces) {
        // Grab a pointer to the touched pieces adjacent pieces.
        Piece *piece = [[self.board.playedPieces objectAtIndex:index.row] objectAtIndex:index.column];
        // If there is an adjacent piece, check and make sure it is not a nil class, then allow a move to be made.
        if ([piece isKindOfClass:[Piece class]] && piece.type != newPiece.type) {
            [piece flipPiece];
        }
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

















