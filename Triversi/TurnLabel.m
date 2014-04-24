//
//  TurnLabel.m
//  Triversi
//
//  Created by Luda on 4/23/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "TurnLabel.h"

@implementation TurnLabel

- (id)initWithFontNamed:(NSString *)fontName {
    
    if (self == [super initWithFontNamed:fontName]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateTextAndColor:)
                                                     name:TURN_CHANGED
                                                   object:NULL];
        self.name = @"turnLabel";
        self.text = @"Red's turn";
        self.fontColor = [SKColor player1Color];
        self.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        
        if ([UIDevice iPad]) {
            self.fontSize = 60.0f;
        } else if ([UIDevice iPhone]) {
            self.fontSize = 30.0f;
        }
    }
    
    return self;
}

- (void)updateTextAndColor:(NSNotification *)notification {
    NSNumber *turn = notification.object;
    if (turn.intValue == kTRTrianglePieceTypeRed) {
        self.text = @"Red's Turn";
        self.fontColor = [SKColor player1Color];
    }
    
    if (turn.intValue == kTRTrianglePieceTypeBlue) {
        self.text = @"Blue's Turn";
        self.fontColor = [SKColor player2Color];
    }
}

@end
