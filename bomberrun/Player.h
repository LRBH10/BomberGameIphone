//
//  Player.h
//  CH05_SLQTSOR
//
//  Created by Lion User on 03/01/13.
//
//

#import "DynamicObject.h"

typedef enum {
    BAS = 0,
    GAUCHE = 1,
    HAUT = 3,
    DROITE = 2
    }Etat;


@interface Player : DynamicObject{
    CGPoint distination;
    int nbrImgInEtat;
    Etat state;
    bool moving;
    bool dead;
    bool vectory;
    bool ia;
}
@property (readwrite)    Etat state;

-(id)initWithImage:(NSString*)filename withSize:(CGRect)sizeAndBegin withNumber:(int)nbr withImgPerState:(int)n IA:(Boolean)isIA;
-(void)destinationAt:(CGPoint) des;

-(void) addBombe;
-(void)deathPlayer;


-(void) vectory:(CGRect)begindeath withNumber:(int)nbr;
-(void) vectoryPlayer;

@end
