
#import "ButtonView.h"
#import "FontLabel.h"
#import "FontLabelStringDrawing.h"
#import "FontManager.h"

@implementation ButtonView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.backgroundColor =[UIColor redColor];
		label = [[FontLabel alloc] initWithFrame:CGRectMake(5, 5, 0, 0) fontName:@"Unisect Extra Bold Oblique" pointSize:12.0f];
		[self addSubview:label];
    }
    return self;
}

- (void)setText:(NSString *)_inText
{
	label.textColor = [UIColor whiteColor];
	label.text = _inText;
	[label sizeToFit];
	label.backgroundColor = nil;
	label.opaque = NO;

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
	[label release];
}

@end

