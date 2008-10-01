#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "GameBoard.h"

@interface GameView : BaseView {
    IBOutlet id selector;
    IBOutlet id moveImg;
    IBOutlet id selectButton;
    IBOutlet id zoomOutButton;
    IBOutlet id moveButton;

    IBOutlet id buildButton;
    IBOutlet id sellButton;
    IBOutlet id upgradeButton;
    IBOutlet id build0;
    IBOutlet id build1;
    IBOutlet id build2;
    IBOutlet id build3;
    IBOutlet id build4;
    IBOutlet id build5;
		
	GameBoard*	board;
	bool		zoomed;
	CGPoint		selectedPos;
	bool		moveMode;
	int			menuState;
	CGPoint		menuPos[6];
	CGPoint		boardPos;

	CGPoint		dragBegin;
}

- (IBAction)ButtonClick:(id)sender;
- (IBAction)MenuButtonClick:(id)sender;

- (void)setUpGameBoard;
- (void)setBoardMove:(CGPoint)pos Zoomed:(bool)zoom;
- (void)zoomOut;
- (void)showMenu:(int)idx Ani:(bool)isAni;
- (void)menuButtonSet:(int)idx show:(bool)isShow;

@end
