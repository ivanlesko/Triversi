//
//  Board.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "Board.h"

#define BOARD @"board"

@implementation Board

+ (Board *)createNewBoardAtPosition:(CGPoint)position {
    // Create the new board.
    Board *newBoard = [Board node];
    newBoard.name = @"board";
    newBoard.position = position;
    
    // Create the triangle grid and add it to the board.
    newBoard.triangleGrid = [SKNode node];
    [newBoard addChild:newBoard.triangleGrid];
    
    int rows = 8;
    int columns = 9;
    
    Piece *placeholderTri = [Piece placePieceAtRow:0
                                         andColumn:0
                                        atPosition:CGPointMake(0, 0)
                                     withPieceType:kTRTrianglePieceTypeNeutral
                                     withDirection:kTRTriangleDirectionUp];
    CGFloat spacing = placeholderTri.frame.size.width / 2.0;
    
    [newBoard addChild:placeholderTri];
    CGPoint origin = CGPointMake(-rows / 2.0 * spacing, rows / 2.0 * spacing + placeholderTri.frame.size.height);
    CGPoint newOrigin = origin;
    
    BOOL upSideDown = NO;
    
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
            Piece *newTri;
            if (upSideDown) {
                newTri = [Piece placePieceAtRow:i
                                      andColumn:j
                                     atPosition:newOrigin
                                  withPieceType:kTRTrianglePieceTypeNeutral
                                  withDirection:kTRTriangleDirectionDown];
            } else {
                newTri = [Piece placePieceAtRow:i
                                      andColumn:j
                                     atPosition:newOrigin
                                  withPieceType:kTRTrianglePieceTypeNeutral
                                  withDirection:kTRTriangleDirectionUp];
            }
            
            newTri.name   = [NSString stringWithFormat:@"piece%d%d", i, j];
            upSideDown = !upSideDown;
            [newBoard.triangleGrid addChild:newTri];
            newOrigin = CGPointMake(newOrigin.x + spacing, newOrigin.y);
        }
        newOrigin = CGPointMake(origin.x, newOrigin.y - placeholderTri.frame.size.height);
    }
    
    [placeholderTri removeFromParent];
    
    // Create the played pieces node and add it to the baord.
    newBoard.playedPieces = [SKNode node];
    [newBoard addChild:newBoard.playedPieces];
    newBoard.playedPieces.position = position;
    
    return newBoard;
}

@end









