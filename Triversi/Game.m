//
//  Game.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "Game.h"

@implementation Game

- (id)init {
    if (self = [super init]) {
        self.turn = kTRPieceColorPlayer1;
        self.moves = [NSMutableArray array];
        self.players = [NSMutableArray array];
        
        Player *player1 = [[Player alloc] initWithPieceColor:kTRPieceColorPlayer1];
        Player *player2 = [[Player alloc] initWithPieceColor:kTRPieceColorPlayer2];
        
        [self.players addObjectsFromArray:@[player1, player2]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moveWasMade:)
                                                 name:PLACED_NEW_PIECE
                                               object:nil];
    
    return self;
}

- (void)moveWasMade:(NSNotification *)notification {
    Piece *newPiece = notification.object;
    
    Move *newMove = [Move createMoveWithRow:newPiece.row
                                     column:newPiece.column
                                       type:self.turn ? kTRTrianglePieceTypeRed : kTRTrianglePieceTypeBlue
                                  direction:newPiece.direction];
    
    [self.moves addObject:newMove];
    newMove.order = [self.moves indexOfObject:newMove];
}

@end
