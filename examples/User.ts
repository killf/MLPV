declare type int = number;
declare type double = number;

class User {
    id: int;

    /**
     * 用户名
     * @required
     * @minLength 3
     * @maxLength 32
     * @pattern [a-zA-Z_]+[a-zA-Z0-1_]
     * */
    name: string;

    /**
     * 密码
     * @required
     * @minLength 5
     * @maxLength 32
     * */
    passowrd: string;
}