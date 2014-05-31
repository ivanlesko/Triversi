//
//  GCTurnBasedMatchHelper.h
//  Triversi
//
//  Created by Luda on 5/31/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCTurnBasedMatchHelper : NSObject <GKTurnBasedMatchmakerViewControllerDelegate>

@property (nonatomic, strong) UIViewController *presentingViewController;

+ (GCTurnBasedMatchHelper *)sharedInstance;

- (void)findMatchWithNumberOfPlayers:(int)number withViewController:(UIViewController *)viewController;

@end
