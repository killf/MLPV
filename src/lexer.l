%{
#include <vector>
#include "parser.hpp"
%}

%x COMMENT COMMENT_LINE
%%

"{"				    {return OpenBraceToken;}
"}"				    {return CloseBraceToken;}
"("				    {return OpenParenToken;}
")"				    {return CloseParenToken;}
"["				    {return OpenBracketToken;}
"]"				    {return CloseBracketToken;}
"."				    {return DotToken;}
"..."				{return DotDotDotToken;}
";"				    {return SemicolonToken;}
","				    {return CommaToken;}
"<"				    {return LessThanToken;}
"</"				{return LessThanSlashToken;}
">"				    {return GreaterThanToken;}
"<="				{return LessThanEqualsToken;}
">="				{return GreaterThanEqualsToken;}
"=="				{return EqualsEqualsToken;}
"!="				{return ExclamationEqualsToken;}
"==="				{return EqualsEqualsEqualsToken;}
"!=="				{return ExclamationEqualsEqualsToken;}
"=>"				{return EqualsGreaterThanToken;}
"+"				    {return PlusToken;}
"-"				    {return MinusToken;}
"*"				    {return AsteriskToken;}
"**"				{return AsteriskAsteriskToken;}
"/"				    {return SlashToken;}
"%"				    {return PercentToken;}
"++"				{return PlusPlusToken;}
"--"				{return MinusMinusToken;}
"<<"				{return LessThanLessThanToken;}
">>"				{return GreaterThanGreaterThanToken;}
"<<<"				{return GreaterThanGreaterThanGreaterThanToken;}
"&"				    {return AmpersandToken;}
"|"				    {return BarToken;}
"^"				    {return CaretToken;}
"!"				    {return ExclamationToken;}
"~"				    {return TildeToken;}
"&&"				{return AmpersandAmpersandToken;}
"||"				{return BarBarToken;}
"?"				    {return QuestionToken;}
":"				    {return ColonToken;}
"@"				    {return AtToken;}
"="				    {return EqualsToken;}
"+="				{return PlusEqualsToken;}
"-="				{return MinusEqualsToken;}
"*="				{return AsteriskEqualsToken;}
"**="				{return AsteriskAsteriskEqualsToken;}
"/="				{return SlashEqualsToken;}
"%="				{return PercentEqualsToken;}
"<<="				{return LessThanLessThanEqualsToken;}
">>="				{return GreaterThanGreaterThanEqualsToken;}
">>>="				{return GreaterThanGreaterThanGreaterThanEqualsToken;}
"&="				{return AmpersandEqualsToken;}
"|="				{return BarEqualsToken;}
"^="				{return CaretEqualsToken;}
"break"				{return BreakKeyword;}
"case"				{return CaseKeyword;}
"catch"				{return CatchKeyword;}
"class"				{return ClassKeyword;}
"const"				{return ConstKeyword;}
"continue"			{return ContinueKeyword;}
"debugger"			{return DebuggerKeyword;}
"default"			{return DefaultKeyword;}
"delete"			{return DeleteKeyword;}
"do"				{return DoKeyword;}
"else"				{return ElseKeyword;}
"enum"				{return EnumKeyword;}
"export"			{return ExportKeyword;}
"exports"			{return ExtendsKeyword;}
"false"				{return FalseKeyword;}
"finally"			{return FinallyKeyword;}
"for"				{return ForKeyword;}
"function"			{return FunctionKeyword;}
"if"				{return IfKeyword;}
"import"			{return ImportKeyword;}
"in"				{return InKeyword;}
"instanceof"		{return InstanceOfKeyword;}
"new"				{return NewKeyword;}
"null"				{return NullKeyword;}
"return"			{return ReturnKeyword;}
"super"				{return SuperKeyword;}
"switch"			{return SwitchKeyword;}
"this"				{return ThisKeyword;}
"throw"				{return ThrowKeyword;}
"true"				{return TrueKeyword;}
"try"				{return TryKeyword;}
"typeof"			{return TypeOfKeyword;}
"var"				{return VarKeyword;}
"void"				{return VoidKeyword;}
"while"				{return WhileKeyword;}
"with"				{return WithKeyword;}
"implements"		{return ImplementsKeyword;}
"interface"			{return InterfaceKeyword;}
"let"				{return LetKeyword;}
"package"			{return PackageKeyword;}
"private"			{return PrivateKeyword;}
"protected"			{return ProtectedKeyword;}
"public"			{return PublicKeyword;}
"static"			{return StaticKeyword;}
"yield"				{return YieldKeyword;}
"abstract"			{return AbstractKeyword;}
"as"				{return AsKeyword;}
"any"				{return AnyKeyword;}
"async"				{return AsyncKeyword;}
"await"				{return AwaitKeyword;}
"boolean"			{return BooleanKeyword;}
"constructor"		{return ConstructorKeyword;}
"declare"			{return DeclareKeyword;}
"get"				{return GetKeyword;}
"infer"				{return InferKeyword;}
"is"				{return IsKeyword;}
"keyof"				{return KeyOfKeyword;}
"module"			{return ModuleKeyword;}
"namespace"			{return NamespaceKeyword;}
"never"				{return NeverKeyword;}
"readonly"			{return ReadonlyKeyword;}
"require"			{return RequireKeyword;}
"number"			{return NumberKeyword;}
"object"			{return ObjectKeyword;}
"set"				{return SetKeyword;}
"string"			{return StringKeyword;}
"symbol"			{return SymbolKeyword;}
"type"				{return TypeKeyword;}
"unique"			{return UniqueKeyword;}
"from"				{return FromKeyword;}
"global"			{return GlobalKeyword;}
"of"				{return OfKeyword;}

[0-9]+(\.[0-9]+)?   { yylval.NUMBER = atof(yytext); return NUMBER; }

[a-zA-Z_][a-zA-Z0-9]* { yylval.ID = strdup(yytext); return ID; }

\n                  { return CR; }
[ \t]               { /*ignore white space*/ }
.                   { fprintf(stderr, "lexical error: %s\n", yytext); exit(-1); }



"//".*              {/*ignore single line comment*/}
"/*"                { BEGIN(COMMENT); }
<COMMENT>@          { BEGIN(COMMENT_LINE); }
<COMMENT_LINE>\n    { BEGIN(COMMENT); }
<COMMENT_LINE>"*/"  { BEGIN(INITIAL); }
<COMMENT>"*/"       { BEGIN(INITIAL); }
<COMMENT>.          { /*ignore otherwise @*/ }

<COMMENT_LINE>"required"            { return CMT_REQUIRED; }
<COMMENT_LINE>"maximum"             { return CMT_MAXIMUM; }
<COMMENT_LINE>"minimum"             { return CMT_MINIMUM; }
<COMMENT_LINE>"exclusiveMaximum"    { return CMT_EXCLUSIVE_MAXIMUM; }
<COMMENT_LINE>"exclusiveMinimum"    { return CMT_EXCLUSIVE_MINIMUM; }
<COMMENT_LINE>"multipleOf"          { return CMT_MULTIPLE_OF; }
<COMMENT_LINE>"maxLength"           { return CMT_MAX_LENGTH; }
<COMMENT_LINE>"minLength"           { return CMT_MIN_LENGTH; }
<COMMENT_LINE>"pattern"             { return CMT_PATTERN; }
<COMMENT_LINE>"format"              { return CMT_FORMAT; }
<COMMENT_LINE>"formatMaximum"       { return CMT_FORMAT_MAXIMUM; }
<COMMENT_LINE>"formatMinimum"       { return CMT_FORMAT_MINIMUM; }
<COMMENT_LINE>"formatExclusiveMaximum" { return CMT_FORMAT_EXCLUSIVE_MAXIMUM; }
<COMMENT_LINE>"formatExclusiveMinimum" { return CMT_FORMAT_EXCLUSIVE_MINIMUM; }
<COMMENT_LINE>"maxItems"            { return CMT_MAX_ITEMS; }
<COMMENT_LINE>"minItems"            { return CMT_MIN_ITEMS; }
<COMMENT_LINE>"uniqueItems"         { return CMT_UNIQUE_ITEMS; }
<COMMENT_LINE>"items"               { return CMT_ITEMS; }
<COMMENT_LINE>"additionalItems"     { return CMT_ADDITIONAL_ITEMS; }
<COMMENT_LINE>"contains"            { return CMT_CONTAINS; }
<COMMENT_LINE>"if"                  { return CMT_IF; }

<COMMENT_LINE>[a-zA-Z_][a-zA-Z0-9]* { yylval.CMT_ID = strdup(yytext); return CMT_ID; }
<COMMENT_LINE>[0-9]+(\.[0-9]+)?     { yylval.CMT_NUMBER = atof(yytext); return CMT_NUMBER; }
<COMMENT_LINE>"true"                { yylval.CMT_BOOLEAN = true; return CMT_BOOLEAN; }
<COMMENT_LINE>"false"               { yylval.CMT_BOOLEAN = false; return CMT_BOOLEAN; }

%%

int yywrap(void){ return 0; }