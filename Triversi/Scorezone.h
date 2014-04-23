//
//  Scorezone.h
//  Triversi
//
//  Created by Luda on 4/23/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Game.h"

@interface Scorezone : SKNode

@property (nonatomic, strong) SKLabelNode *player1scoreLabel;
@property (nonatomic, strong) SKLabelNode *player2scoreLabel;

+ (Scorezone *)createScorezoneAtPosition:(CGPoint)position;

@end
