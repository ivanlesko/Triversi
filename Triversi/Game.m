//
//  Game.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "Game.h"

@implementation Game

- (void)addMoveToMoves:(Move *)move {
    [self.moves addObject:move];
    move.order = [self.moves indexOfObject:move];
}

@end
