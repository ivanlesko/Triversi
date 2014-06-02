//
//  GameScene.h
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>
#import "Board.h"
#import "Game.h"
#import "Scorezone.h"
#import "GameCenterManager.h"
#import "GCTurnBasedMatchHelper.h"


@interface GameScene : SKScene

@property (nonatomic, strong) Board *board;
@property (nonatomic, strong) Game *game;

@end
