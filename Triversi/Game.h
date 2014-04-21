//
//  Game.h
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Move.h"
#import "Player.h"
#import "Piece.h"

@interface Game : NSObject

/// All the moves that have been made by both players.
@property (nonatomic, strong) NSMutableArray *moves;

/// An array of players that are in the current game.
@property (nonatomic, strong) NSMutableArray *players;

/// Determine's what the result of the match was.
/// Can either be player1, player2, or a draw.
@property (nonatomic) kTRResult result;

/// The current player's turn.  Can either be player1 or player2
@property (nonatomic) kTRTrianglePieceType turn;

@end
