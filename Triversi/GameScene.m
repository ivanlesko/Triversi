//
//  GameScene.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "GameScene.h"
#import "Piece.h"
#import "UpPiece.h"
#import "DownPiece.h"

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
                        if (touchedPiece.direction == kTRTriangleDirectionUp) {
                            UpPiece *newUpPiece = [UpPiece placePieceAtRow:touchedPiece.row
                                                                 andColumn:touchedPiece.column
                                                                atPosition:touchedPiece.position
                                                             withPieceType:self.game.turn ? kTRTrianglePieceTypeBlue : kTRTrianglePieceTypeRed
                                                             withDirection:kTRTriangleDirectionUp
                                                                 withBoard:self.board];
                        }
                        
                        if (touchedPiece.direction == kTRTriangleDirectionDown) {
                            DownPiece *newDownPiece = [DownPiece placePieceAtRow:touchedPiece.row
                                                                 andColumn:touchedPiece.column
                                                                atPosition:touchedPiece.position
                                                             withPieceType:self.game.turn ? kTRTrianglePieceTypeBlue : kTRTrianglePieceTypeRed
                                                             withDirection:kTRTriangleDirectionDown
                                                                 withBoard:self.board];
                        }
                        
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
    return YES;
}


- (void)changeTurn {
    if (self.game.turn == kTRPieceColorPlayer1) {
        self.game.turn = kTRPieceColorPlayer2;
    } else {
        self.game.turn = kTRPieceColorPlayer1;
    }
}

@end

















