//
//  Game.h
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

/// All the moves that have been made by both players.
@property (nonatomic, strong) NSMutableArray *moves;

/// The current player's turn.  Can either be player1 or player2


@end
