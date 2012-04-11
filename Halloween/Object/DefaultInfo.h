/* 
    우선 몇몇 기본값가저오느데 사용 
    추후에~ 정리하시조~ ^^;;;
 
 */

#import "Object.h"

typedef enum {
    BOX_NONE = -1,  
    BOX_BUBBLE = 0,
    BOX_WATER ,
    BOX_COCO,
}BOX_TYPE;  
/* Gum 별로 정보는 따로 저장해서 관리 하자*/
typedef struct _gumattactinfo
{
    float   damage;         /* 공격력 */
	int     speed;          /* 이동속도 */
    int     range;          /* 공격 범위 ( 이동 범위 ) */ 
    int     rad;            /* 공격 반경 */
 //   int     probability;    /* 확률 - 일정한데미지 이상에 대한 확률?ㅋ  */
} GumAttactInfo;

//--------Attect는 무슨 단어임?[ㅡ_ㅡ?] Attack 이조;;;;;; 오타....ㅡ.ㅡ; 

/* 유령 정보 */
#if 0
typedef enum {
    GHOST_BASE  = 0,
    GHOST_SPARTA, 
};
typedef struct _ghostdefenseinfo
 {
     float  defensive;   /* 방어력 */
     int    speed;       /* 이동속도 */
} GhostDefenseInfo;

#endif



@interface DefaultManager : Object {
    
    GumAttactInfo   gumInfo[2];
}

+ (DefaultManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (void)loadGumInfo;
- (GumAttactInfo)getGumInfo:(int)type;
@end
