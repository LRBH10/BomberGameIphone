//
//  WelcomeScene.h
//  CH05_SLQTSOR
//
//  Created by Lion User on 12/01/13.
//
//

#import "AbstractScene.h"
#import "StaticObject.h"
@interface WelcomeScene : AbstractScene{
	float transY;
	CGPoint touchLocation;

    
    StaticObject *welcomeImage;
    StaticObject *exit;
    
    StaticObject *newGame;
    StaticObject *restart;
   
    
    AVAudioPlayer *audioPlayer;
    
    bool isrunning;
    
	ImageRenderManager *sharedImageRenderManager;
}


- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView;

@end
