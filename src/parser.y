%{
#include <stdio.h>
#include <string>
#include <vector>
#include <map>
#include <math.h>

int yyerror(char *s);
int yylex();
%}

%define api.value.type union

%token OpenBraceToken CloseBraceToken OpenParenToken CloseParenToken OpenBracketToken CloseBracketToken DotToken DotDotDotToken SemicolonToken CommaToken LessThanToken LessThanSlashToken GreaterThanToken LessThanEqualsToken GreaterThanEqualsToken EqualsEqualsToken ExclamationEqualsToken EqualsEqualsEqualsToken ExclamationEqualsEqualsToken EqualsGreaterThanToken PlusToken MinusToken AsteriskToken AsteriskAsteriskToken SlashToken PercentToken PlusPlusToken MinusMinusToken LessThanLessThanToken GreaterThanGreaterThanToken GreaterThanGreaterThanGreaterThanToken AmpersandToken BarToken CaretToken ExclamationToken TildeToken AmpersandAmpersandToken BarBarToken QuestionToken ColonToken AtToken EqualsToken PlusEqualsToken MinusEqualsToken AsteriskEqualsToken AsteriskAsteriskEqualsToken SlashEqualsToken PercentEqualsToken LessThanLessThanEqualsToken GreaterThanGreaterThanEqualsToken GreaterThanGreaterThanGreaterThanEqualsToken AmpersandEqualsToken BarEqualsToken CaretEqualsToken BreakKeyword CaseKeyword CatchKeyword ClassKeyword ConstKeyword ContinueKeyword DebuggerKeyword DefaultKeyword DeleteKeyword DoKeyword ElseKeyword EnumKeyword ExportKeyword ExtendsKeyword FalseKeyword FinallyKeyword ForKeyword FunctionKeyword IfKeyword ImportKeyword InKeyword InstanceOfKeyword NewKeyword NullKeyword ReturnKeyword SuperKeyword SwitchKeyword ThisKeyword ThrowKeyword TrueKeyword TryKeyword TypeOfKeyword VarKeyword VoidKeyword WhileKeyword WithKeyword ImplementsKeyword InterfaceKeyword LetKeyword PackageKeyword PrivateKeyword ProtectedKeyword PublicKeyword StaticKeyword YieldKeyword AbstractKeyword AsKeyword AnyKeyword AsyncKeyword AwaitKeyword BooleanKeyword ConstructorKeyword DeclareKeyword GetKeyword InferKeyword IsKeyword KeyOfKeyword ModuleKeyword NamespaceKeyword NeverKeyword ReadonlyKeyword RequireKeyword NumberKeyword ObjectKeyword SetKeyword StringKeyword SymbolKeyword TypeKeyword UniqueKeyword FromKeyword GlobalKeyword OfKeyword
%token NUMBER ID
%token CR

%token CMT_REQUIRED

%type <double> NUMBER
%type <char*> ID

%%

start           :
                | start declare_stmt
                | start class_stmt
                | start CR
                ;

declare_stmt    : DeclareKeyword TypeKeyword type_name EqualsToken type_name SemicolonToken
                ;

class_stmt      : ClassKeyword class_name
                | ClassKeyword class_name class_body
                ;

class_body      : OpenBraceToken class_members CloseBraceToken
                ;

class_members   :
                | class_members class_property
                | class_members CR
                ;

class_property  : property_name SemicolonToken
                | property_name ColonToken type_name SemicolonToken
                ;

type_name       : ID | NumberKeyword | ObjectKeyword | StringKeyword | BooleanKeyword | AnyKeyword
                ;

class_name      : ID
                ;

property_name   : ID
                ;

%%

int yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}