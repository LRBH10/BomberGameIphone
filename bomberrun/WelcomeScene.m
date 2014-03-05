//
//  WelcomeScene.m
//  CH05_SLQTSOR
//
//  Created by Lion User on 12/01/13.
//
//

#import "Image.h"
#import "ImageRenderManager.h"
#import "WelcomeScene.h"
#import "GameController.h"
#import "GameScene.h"


@implementation WelcomeScene
- (id) init
{
	self = [super init];
	if (self != nil) {


		sharedImageRenderManager = [ImageRenderManager sharedImageRenderManager];
		welcomeImage = [[StaticObject alloc] initWithImage:@"welcome.png" withSize:CGRectMake(0, 0, 206, 244)];
        
        newGame = [[StaticObject alloc] initWithImage:@"newGame.gif" withSize:CGRectMake(0, 0, 216, 78) ];
        newGame.postion = CGPointMake(160, 150);

        exit =[[StaticObject alloc] initWithImage:@"exit.gif" withSize:CGRectMake(0, 0, 197, 78) ];
        exit.postion = CGPointMake(160, 70);

        
        
        //[welcomeImage playSong:@"%@/test.mp3" withRepeatNbr:1];

        /*NSURL *url=[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/test.mp3",[[NSBundle mainBundle] resourcePath]]];
        NSError *error;
        audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        audioPlayer.numberOfLoops=5;
        [audioPlayer play];//*/
        
    }
	return self;
}



- (void)updateSceneWithDelta:(float)aDelta {
    
}
- (void)renderScene{
    //[[welcomeImage current] renderCenteredAtPoint: [welcomeImage postion]];
     
    [newGame renderObject:sharedImageRenderManager];
    [exit renderObject:sharedImageRenderManager];

}



- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView {
    UITouch *touch = [touches anyObject];
    touchLocation = [touch locationInView:aView];
    touchLocation.y = 480 - touchLocation.y;
    printf("%lf, %lf     ",touchLocation.x,touchLocation.y);
    
    if ([newGame colusionWithPoint:touchLocation]) {
        
        AbstractScene *game = [[GameScene alloc] init];
        //[[GameController sharedGameController].gameScenes setValue:game forKey:@"game"];
        //[game release];
        
        
        //AbstractScene *inter =[[GameController sharedGameController].gameScenes objectForKey:@"game"];
        [[GameController sharedGameController] setCurrentScene:game ];
    }
    
    
    
}



@end
