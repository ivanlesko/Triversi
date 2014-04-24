//
//  Scorezone.m
//  Triversi
//
//  Created by Luda on 4/23/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "Scorezone.h"

@implementation Scorezone

+ (Scorezone *)createScorezoneAtPosition:(CGPoint)position {
    Scorezone *newScorezone = [Scorezone node];
    newScorezone.position = position;
    newScorezone.name = @"scoreZone";
    
    CGFloat labelDistance = 0.0f;
    CGFloat textSize = 0.0f;
    
    if ([UIDevice iPad]) {
        labelDistance = 100.0f;
        textSize = 80.0f;
    } else if ([UIDevice iPhone]) {
        labelDistance = 50.0f;
        textSize = 40.0f;
    }
    
    newScorezone.player1scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Bold"];
    newScorezone.player1scoreLabel.fontColor = [SKColor player1Color];
    newScorezone.player1scoreLabel.position = CGPointMake(-labelDistance, 0);
    newScorezone.player1scoreLabel.fontSize = textSize;
    newScorezone.player1scoreLabel.text = @"0";
    newScorezone.player1scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    [newScorezone addChild:newScorezone.player1scoreLabel];
    
    newScorezone.player2scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Bold"];
    newScorezone.player2scoreLabel.fontColor = [SKColor player2Color];
    newScorezone.player2scoreLabel.position = CGPointMake(labelDistance, 0);
    newScorezone.player2scoreLabel.fontSize = textSize;
    newScorezone.player2scoreLabel.text = @"0";
    newScorezone.player2scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    [newScorezone addChild:newScorezone.player2scoreLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:newScorezone
                                             selector:@selector(updateScoreLabelSizesForTurn:)
                                                 name:TURN_CHANGED
                                               object:NULL];
    
    return newScorezone;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    Game *game = object;
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(player1score))]) {
        self.player1scoreLabel.text = [NSString stringWithFormat:@"%@", game.player1score];
    }
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(player2score))]) {
        self.player2scoreLabel.text = [NSString stringWithFormat:@"%@", game.player2score];
    }
}

- (void)updateScoreLabelSizesForTurn:(NSNotification *)notification {
    SKAction *scaleUp = [SKAction scaleTo:1.1 duration:0.2];
    SKAction *scaleDown = [SKAction scaleTo:1.0 duration:0.2];
    
    
    NSNumber *turn = notification.object;
    if (turn.intValue == kTRTrianglePieceTypeRed) {
        [self.player1scoreLabel runAction:scaleUp];
        [self.player2scoreLabel runAction:scaleDown];
    }
    
    if (turn.intValue == kTRTrianglePieceTypeBlue) {
        [self.player1scoreLabel runAction:scaleDown];
        [self.player2scoreLabel runAction:scaleUp];
    }
}

@end






