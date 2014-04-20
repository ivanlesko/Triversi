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
    newBoard.name = BOARD;
    newBoard.position = position;
    
    // Create the triangle grid and add it to the board.
    newBoard.triangleGrid = [SKNode node];
    [newBoard addChild:newBoard.triangleGrid];
    newBoard.triangleGrid.name = TRIANGLE_GRID;
    
    // We create a placeholder triangle just to use its dimensions.  It does not show up on the board.
    Piece *placeholderTri = [Piece placePieceAtRow:0
                                         andColumn:0
                                        atPosition:CGPointMake(0, 0)
                                     withPieceType:kTRTrianglePieceTypeNeutral
                                     withDirection:kTRTriangleDirectionUp
                                         withBoard:newBoard];
    
    CGFloat spacing = placeholderTri.frame.size.width / 2.0;
    
    [newBoard addChild:placeholderTri];
    
    // The origin of the very first piece.
    CGPoint origin = CGPointMake(-ROWS / 2.0 * spacing, ROWS / 2.0 * spacing + placeholderTri.frame.size.height);
    [placeholderTri removeFromParent];
    
    // newOrigin will be moved everytime a piece of the board will be placed.
    CGPoint newOrigin = origin;
    
    BOOL upSideDown = NO;
    
    // Populate the board with gray pieces.
    newBoard.emptyPieces  = [NSMutableArray array];
    for (NSInteger i = 0; i < ROWS; i++) {
        [newBoard.emptyPieces addObject:[NSMutableArray array]];
        for (NSInteger j = 0; j < COLUMNS; j++) {
            Piece * newTri = [Piece placePieceAtRow:i
                                          andColumn:j
                                         atPosition:newOrigin
                                      withPieceType:kTRTrianglePieceTypeNeutral
                                      withDirection:upSideDown ? kTRTriangleDirectionDown : kTRTriangleDirectionUp
                                          withBoard:newBoard];
            
            newTri.name = EMPTY_SPACE;
            [newBoard.triangleGrid addChild:newTri];
            upSideDown = !upSideDown;
            newOrigin = CGPointMake(newOrigin.x + spacing, newOrigin.y);
            [[newBoard.emptyPieces objectAtIndex:i] addObject:newTri];
        }
        newOrigin = CGPointMake(origin.x, newOrigin.y - placeholderTri.frame.size.height);
    }
    
    newBoard.piecesNode = [SKNode node];
    [newBoard addChild:newBoard.piecesNode];
    
    // Create a played pieces array filled with null objects.
    newBoard.playedPieces = [NSMutableArray array];
    for (int i = 0; i < ROWS; i++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        [newBoard.playedPieces addObject:rowArray];
        for (int j = 0; j < COLUMNS; j++) {
            [[newBoard.playedPieces objectAtIndex:i] addObject:[NSNull null]];
        }
    }
    
    // The board listens to every piece that is placed on it.
    [[NSNotificationCenter defaultCenter] addObserver:newBoard
                                             selector:@selector(replaceNullWithNewPiece:)
                                                 name:PLACED_NEW_PIECE
                                               object:nil];
    
    return newBoard;
}

- (void)placeInitialPieces {
    NSIndexPath *player1path1 = [NSIndexPath indexPathForRow:3 inSection:3];
    NSIndexPath *player1path2 = [NSIndexPath indexPathForRow:3 inSection:5];
    NSIndexPath *player1path3 = [NSIndexPath indexPathForRow:4 inSection:4];
    
    NSIndexPath *player2path1 = [NSIndexPath indexPathForRow:3 inSection:4];
    NSIndexPath *player2path2 = [NSIndexPath indexPathForRow:4 inSection:3];
    NSIndexPath *player2path3 = [NSIndexPath indexPathForRow:4 inSection:5];
    
    NSArray *player1paths = @[player1path1, player1path2, player1path3];
    NSArray *player2paths = @[player2path1, player2path2, player2path3];
    
    // Place the initial player1 pieces on the board.
    for (NSIndexPath *path in player1paths) {
        for (Piece *piece in self.triangleGrid.children) {
            if (piece.row == path.row && piece.column == path.section) {
                switch (piece.direction) {
                    case kTRTriangleDirectionUp:
                        
                        break;
                        
                    case kTRTriangleDirectionDown:
                        
                        break;
                }
                Piece *player1piece = [Piece placePieceAtRow:piece.row
                                                   andColumn:piece.column
                                                  atPosition:piece.position
                                               withPieceType:kTRTrianglePieceTypeRed
                                               withDirection:piece.direction
                                                   withBoard:self];
            }
        }
    }
    
    // Place the player2 pieces on the board.
    for (NSIndexPath *path in player2paths) {
        for (Piece *piece in self.triangleGrid.children) {
            if (piece.row == path.row && piece.column == path.section) {
                Piece *player2piece = [Piece placePieceAtRow:piece.row
                                                   andColumn:piece.column
                                                  atPosition:piece.position
                                               withPieceType:kTRTrianglePieceTypeBlue
                                               withDirection:piece.direction
                                                   withBoard:self];
            }
        }
    }
}

- (void)replaceNullWithNewPiece:(NSNotification *)notification {
    Piece *newPiece = notification.object;
    [self.piecesNode addChild:newPiece];
    [[self.playedPieces objectAtIndex:newPiece.row] replaceObjectAtIndex:newPiece.column withObject:newPiece];
    
}

@end









