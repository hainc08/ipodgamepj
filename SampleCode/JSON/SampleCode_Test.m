

//  Json ManPage ( API 설명 )
//   http://stig.github.com/json-framework/api/index.html
//  연동 방식중에 하나로 사용될 가능성 있음  논의 필요..




//웹페이지에서 json 파일 읽어 오기 


NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://pro.ctlok.com/data.json"]];

NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

NSString *jsonStr = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];


// 아래 내용 과 통합하면 .. 끝..

//sample 설명 
// http://www.open-tutorial.com/2010/08/28/objective-c-parse-json-string-to-object/
/* Sample json 파일 */
//------------------------------------------------------------------------------

{
    "glossary": {
        "title": "example glossary",
        "GlossDiv": {
            "title": "S",
            "GlossList": {
                "GlossEntry": {
                    "ID": "SGML",
                    "SortAs": "SGML",
                    "GlossTerm": "Standard Generalized Markup Language",
                    "Acronym": "SGML",
                    "Abbrev": "ISO 8879:1986",
                    "GlossDef": {
                        "para": "A meta-markup language, used to create markup languages such as DocBook.",
                        "GlossSeeAlso": ["GML", "XML"]
                    },
                    "GlossSee": "markup"
                }
            }
        }
    }
}



//------------------------------------------------------------------------------
NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
NSString *jsonStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];

SBJsonParser *parser = [[SBJsonParser alloc] init];
NSDictionary *json = [parser objectWithString:jsonStr error:nil];

NSDictionary *glossary = [json objectForKey:@"glossary"];
NSString *glossaryTitle = [glossary objectForKey:@"title"];

NSDictionary *glossDiv = [glossary objectForKey:@"GlossDiv"];
NSString *glossDivTitle = [glossDiv objectForKey:@"title"];

NSArray *glossSeeAlso = [[[[glossDiv objectForKey:@"GlossList"]
						   objectForKey: @"GlossEntry"]
						  objectForKey: @"GlossDef"]
						 objectForKey: @"GlossSeeAlso"];

NSLog(@"Glossary Title: %@", glossaryTitle);
NSLog(@"GlossDiv Title : %@", glossDivTitle);

NSLog(@"GlossSeeAlso item 1: %@", [glossSeeAlso objectAtIndex:0]);
NSLog(@"GlossSeeAlso item 2: %@", [glossSeeAlso objectAtIndex:1]);




//출력 값 

//------------------------------------------------------------------------------
2010-08-27 15:15:44.003 JSON[47655:207] Glossary Title: example glossary
2010-08-27 15:15:44.049 JSON[47655:207] GlossDiv Title : S
2010-08-27 15:15:44.050 JSON[47655:207] GlossSeeAlso item 1: GML
2010-08-27 15:15:44.050 JSON[47655:207] GlossSeeAlso item 2: XML
