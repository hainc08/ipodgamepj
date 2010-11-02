
#import "ButtonView.h"
#import "FontLabel.h"
#import "FontLabelStringDrawing.h"
#import "FontManager.h"

@implementation ButtonView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		TYPE = 0; // box 
		self.backgroundColor =[UIColor redColor];
		label = [[FontLabel alloc] initWithFrame:CGRectMake(5, 5, 0, 0) fontName:@"Unisect Extra Bold Oblique" pointSize:12.0f];
		[self addSubview:label];
		
		x	= frame.size.width;
		y	= frame.size.height;
    }
    return self;
}

- (void)setView:(int)_inTYPE  fontsize:(float)_insize fontName:(NSString *)_inname fontColor:(UIColor *)_inColor
{
	TYPE = _inTYPE;
	
/*	if(_insize > 0.0f)
		label.pointSize = _insize;
	if(_inname != nil)
		label.zFont = [[FontManager sharedManager] fontWithName:_inname];*/
	if(_inColor != nil)
		label.textColor = _inColor;
	
	[self setNeedsDisplay];
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
	
	if(TYPE == 0 )
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextSetRGBStrokeColor(context, 1,1,1,1);
		CGContextSetLineWidth(context, 1);
	
		int i = 0;
	
		while(i < y){
			if( i > ARRAY && i < y - ARRAY )
			{
				CGContextMoveToPoint(context, 0, i);
				CGContextAddLineToPoint(context, ARRAY, i);
				CGContextStrokePath(context);
				CGContextMoveToPoint(context, x - ARRAY, i);
				CGContextAddLineToPoint(context, x, i);
				CGContextStrokePath(context);
			
			}
			else 
			{
				CGContextMoveToPoint(context, 0, i);
				CGContextAddLineToPoint(context, x, i);
				CGContextStrokePath(context);
			
			}
			i++;
		}
	}
}


- (void)dealloc {
    [super dealloc];
	[label release];
}

@end

