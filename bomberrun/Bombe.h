//
//  Bombe.h
//  CH05_SLQTSOR
//
//  Created by Lion User on 10/01/13.
//
//

#import "DynamicObject.h"
@class Player;
@interface Bombe : DynamicObject{
    int nbrImgInExplosion;
    bool dead;
    int puissance;
}
@property (readonly) bool dead;

-(id)initWithImage:(NSString*)filename withSize:(CGRect)sizeAndBegin withNumber:(int)nbr withTime:(NSTimeInterval) miliseconds withPuissance:(int)puissanc AtPostion:(CGPoint) postion;

-(void)deathBombe;





@end
