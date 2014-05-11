//
//  TriversiViewController.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "TriversiViewController.h"
#import "GameScene.h"

#import "TextureStore.h"

@interface TriversiViewController() {
    
}

@property (nonatomic, strong) SKView *skView;

@end

@implementation TriversiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure the view.
    self.skView = (SKView *)self.view;
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    GameScene * scene = [[GameScene alloc] initWithSize:self.view.bounds.size];
    scene.backgroundColor = [SKColor whiteColor];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [self.skView presentScene:scene];
    
    TextureStore *textGen = [TextureStore sharedInstance];
    textGen.view = self.skView;
    
    SKTexture *text = [[TextureStore sharedInstance] textureFromPieceType:kTRTrianglePieceTypeBlue andDirection:kTRTriangleDirectionDown];
    NSLog(@"test texture: %@", text);
    
    SKSpriteNode *triNode = [SKSpriteNode spriteNodeWithTexture:text];
    triNode.position = self.view.center;
    
    [scene addChild:triNode];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end







