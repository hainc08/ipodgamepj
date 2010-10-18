
#import "ButtonView.h"


@implementation ButtonView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.backgroundColor =[UIColor redColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetRGBStrokeColor(context, 1,1,1,1);
	CGContextSetLineWidth(context, 1);
	
	int i = 0;
	
	while(i < BUTTON_Y){
		if( i > ARRAY && i < BUTTON_Y - ARRAY )
		{
			CGContextMoveToPoint(context, 0, i);
			CGContextAddLineToPoint(context, ARRAY, i);
			CGContextStrokePath(context);
			CGContextMoveToPoint(context, BUTTON_X - ARRAY, i);
			CGContextAddLineToPoint(context, BUTTON_X, i);
			CGContextStrokePath(context);
			
		}
		else 
		{
			CGContextMoveToPoint(context, 0, i);
			CGContextAddLineToPoint(context, BUTTON_X, i);
			CGContextStrokePath(context);
			
		}
		i++;
	}
}


- (void)dealloc {
    [super dealloc];
}

@end

