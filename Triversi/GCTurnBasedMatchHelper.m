//
//  GCTurnBasedMatchHelper.m
//  Triversi
//
//  Created by Luda on 5/31/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "GCTurnBasedMatchHelper.h"
#import "GameCenterManager.h"

@implementation GCTurnBasedMatchHelper

+ (GCTurnBasedMatchHelper *)sharedInstance {
    static GCTurnBasedMatchHelper *singleton;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    
    return singleton;
}

- (void)findMatchWithNumberOfPlayers:(int)number withViewController:(UIViewController *)viewController {
    // Game Center is not available so no reason to continue on.
    if (![[GameCenterManager sharedManager] isGameCenterAvailable]) {
        return;
    } else {
        self.presentingViewController = viewController;
        
        GKMatchRequest *request = [[GKMatchRequest alloc] init];
        request.minPlayers = number;
        request.maxPlayers = number;
        
        GKTurnBasedMatchmakerViewController *mmvc = [[GKTurnBasedMatchmakerViewController alloc] initWithMatchRequest:request];
        mmvc.turnBasedMatchmakerDelegate = self;
        mmvc.showExistingMatches = YES;
        
        [self.presentingViewController presentViewController:mmvc animated:YES completion:^{
            // Any presenting completion code goes here.b
        }];
    }
}

- (void)turnBasedMatchmakerViewController:(GKTurnBasedMatchmakerViewController *)viewController didFindMatch:(GKTurnBasedMatch *)match {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"did find match, %@", match);
}

- (void)turnBasedMatchmakerViewControllerWasCancelled:(GKTurnBasedMatchmakerViewController *)viewController {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"cancelled match.");
}

- (void)turnBasedMatchmakerViewController:(GKTurnBasedMatchmakerViewController *)viewController didFailWithError:(NSError *)error {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Error finding match: %@", error.localizedDescription);
}

- (void)turnBasedMatchmakerViewController:(GKTurnBasedMatchmakerViewController *)viewController playerQuitForMatch:(GKTurnBasedMatch *)match {
    NSLog(@"player quit for match, %@, %@", match, match.currentParticipant);
}

@end








