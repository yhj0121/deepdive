정규표현식이란?

정규표현식은 일정한 패턴을 가진 문자열의 집합을 표현하기 위해 사용하는 형식 언어다.

정규표현식은 문자열을 대상으로 패턴 매칭 기능 제공 패턴 매칭 기능을 제공한다.

패틴 매칭 기능:특정 패턴과 일치하는 문자열 검색 추출 또는 치환 할수 있는 기능 말한다.

예시 코드

```jsx
// 사용자로부터 입력받은 휴대폰 전화번호
const tel = "010-1234-567팔";

// 정규 표현식 리터럴로 휴대폰 전화번호 패턴을 정의한다.
const regExp = /^\d{3}-\d{4}-\d{4}$/;

// tel이 휴대폰 전화번호 패턴에 매칭하는지 테스트(확인)한다.
regExp.test(tel); // -> false
```

### 정규 표현식 생성

**정규표현식 용어**

```java
/ regexp /i
```

> /:시작 종료기호

> regexp:패턴

> i:플래그

**정규표현식 만들기**

1.정규식 리터널

```jsx
var re = /ab+c/;
```

2.생성자 함수

```jsx
var re = new RegExp("ab+c");
```

### RegExp 메서드

**1.RegExp.prototype.exec**

exec메서드는 인수로 전달받은 문자열에 대해 정규 표현식의 패턴을 검색하여 매칭 결과를 배열로 반환한다.

```jsx
const regex1 = RegExp('foo*', 'g');
const str1 = 'table football, foosball';
let array1;

while ((array1 = regex1.exec(str1)) !== null) {
  console.log(`Found ${array1[0]}. Next starts at ${regex1.lastIndex}.`);
```

매칭 결과가 없으면 null 값 반환, exec메서드는 문자열 내 모든 패턴을 검색하는 g 플래그를 지정해도 **첫번쨰 매칭결과** 만 반환함

2**.RegExp.prototype.test**

test메서드는 인수로 전달받은 문자열에 대해 정규 표현식을 패턴을 검색여 매칭 결과를 불리언으로 반환

```jsx
const target = "Is this all there is?";
const regExp = /is/;

regExp.test(target); // -> true
```

3**.String.prototype.match**

String표준 빌트인 객체가 제공하는 match 메서드는 대상 문자열과 인수로 전달받은 정규 표현식과의 매칭 결과를 배열로 반환한다.

```jsx
var str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
var regexp = /[A-E]/gi;
var matches_array = str.match(regexp);

console.log(matches_array);
```

match와 exec의 차이점은 g 플래그 지정해도 exec는 하나만 나오고 match는 모든 결과가 나온다.

### 플래그

패턴과 함꼐 정규표현식을 구성하는 플래그는 정규 표현식의 검색 방식을 설정하기 위해 사용한다

| 플래그 | 의미        | 설명                                                     |
| ------ | ----------- | -------------------------------------------------------- |
| i      | ignore case | 대소문자 구별하지 않고 패턴 검색                         |
| g      | Global      | 대상 문자열 내에서 패턴과 일치하는 모든 문자열 전역 검색 |
| m      | Multi line  | 문자열 행이 바뀌더라도 패턴 검색 계속한다.               |

```jsx
const target = "Is this all there is?";

// target 문자열에서 is 문자열을 대소문자를 구별하여 한 번만 검색한다.
target.match(/is/);
// -> ["is", index: 5, input: "Is this all there is?", groups: undefined]

// target 문자열에서 is 문자열을 대소문자를 구별하지 않고 한 번만 검색한다.
target.match(/is/i);
// -> ["Is", index: 0, input: "Is this all there is?", groups: undefined]

// target 문자열에서 is 문자열을 대소문자를 구별하여 전역 검색한다.
target.match(/is/g);
// -> ["is", "is"]

// target 문자열에서 is 문자열을 대소문자를 구별하지 않고 전역 검색한다.
target.match(/is/gi);
// -> ["Is", "is", "is"]
```

### 패턴

정규표현식은 **일정한 규칙**(패턴)을 가진 문자열의 집합을 표현하기 위해 사용하는 형식 언어다

**문자열 검색**

**임의의 문자열 검색**

.은 임의의 문자 한 개를 의미한다 문자의 내용은 무엇이든 상관없음

...인경우 문자 내용상관없이 3자리 문자와 매치해야함

```jsx
const target = "Is this all there is?";

// 임의의 3자리 문자열을 대소문자를 구별하여 전역 검색한다.
const regExp = /.../g;

target.match(regExp); // -> ["Is ", "thi", "s a", "ll ", "the", "re ", "is?"]
```

**반복 검색**

{m,n} 최소m번 최대n번 반복되는 문자열을 의미함

{n}경우는 {n,n}와 같다

```jsx
const target = "A AA B BB Aa Bb AAA";

// 'A'가 최소 1번, 최대 2번 반복되는 문자열을 전역 검색한다.
const regExp = /A{1,2}/g;

target.match(regExp); // -> ["A", "AA", "A", "AA", "A"]
```

{n,}은 최소 n번 이상 반복하는 문자열 의미

```java
const target = 'A AA B BB Aa Bb AAA';

// 'A'가 최소 2번 이상 반복되는 문자열을 전역 검색한다.
const regExp = /A{2,}/g;

target.match(regExp); // -> ["AA", "AAA"]
```

**+**

+는 앞선 패턴이 패턴이 **한번이상** 반복되는 문자열을 의미한다.

```jsx
const target = "A AA B BB Aa Bb AAA";

// 'A'가 최소 한 번 이상 반복되는 문자열('A, 'AA', 'AAA', ...)을 전역 검색한다.
const regExp = /A+/g;

target.match(regExp); // -> ["A", "AA", "A", "AAA"]
```

?

?는 앞선 패턴이 **최대 한 번 이상 반복**되는 문자열을 의미한다.

**{0,1}**과 같은 역활을 한다

/lake?k/g의 경우

lak다음 k가 최대 한번 이상 반복되고 k로 이어지는 문자열도 매치되어야한다

```jsx
const nba = "lakk laker";
```

or 검색

|은 or의 의미를 가진다 /A|B/는 A또는 B 의미

반복되는 경우 +와 함꼐 사용됨

```jsx
const target = "A AA B BB Aa Bb";

// 'A' 또는 'B'가 한 번 이상 반복되는 문자열을 전역 검색한다.
// 'A', 'AA', 'AAA', ... 또는 'B', 'BB', 'BBB', ...
const regExp = /A+|B+/g;

target.match(regExp); // -> ["A", "AA", "B", "BB", "A", "B"]
```

범위 지정할러면[] 내에 -지정

```jsx
const target = "A AA BB ZZ Aa Bb";

// 'A' ~ 'Z'가 한 번 이상 반복되는 문자열을 전역 검색한다.
// 'A', 'AA', 'AAA', ... 또는 'B', 'BB', 'BBB', ... ~ 또는 'Z', 'ZZ', 'ZZZ', ...
const regExp = /[A-Z]+/g;

target.match(regExp); // -> ["A", "AA", "BB", "ZZ", "A", "B"]
```

알파벳 검사 숫자 검사

```jsx
const target = 'AA BB Aa Bb 12';

const regExp = /[A-Za-z]+/g;

target.match(regExp); // -> ["AA", "BB", "Aa", "Bb"]
--------------------------------------------------------------

const target = 'AA BB 12,345';

const regExp = /[0-9]+/g;

target.match(regExp); // -> ["12", "345"]

const regExp = /[0-9,]+/g;

target.match(regExp); // -> ["12,345"]

```

**/d**

숫자를 [0-9]말고 **[\d]**로 대신 가능하기도 하고 [\D]는 숫자 아닌 값만 나온다.

**/w**

알파벳 숫자 언ㄴ더 스코어 의미 [A-Za-z0-9_]랑 같다 /W는 반대로 동작

NOT 동작

^를 이용하면 NOT의 의미를 가진다[^ ]식으로 사용해야하한다

시작 위치로 검색

[]밖에서 **^**는 문자열 시작을 의미

문자열 마지막 위치로 검색

**$**는 문자열 마지막

### 자주 사용하는 정규 표현식

1.특정 단어로 시작하는지 검사

^사용

```java
const url = 'https://example.com';

// 'http://' 또는 'https://'로 시작하는지 검사한다.
/^https?:\/\//.test(url); // -> true
```

2.특정단어로 끝나는지 검사

$사용

```java
const fileName = 'index.html';

// 'html'로 끝나는지 검사한다.
/html$/.test(fileName); // -> true
```

3.숫자로만 이루어진 숫자 검사

\d 명령어 사용

```java
const target = '12345';

// 숫자로만 이루어진 문자열인지 검사한다.
/^\d+$/.test(target); // -> true
```

4.하나 이상의 공백으로 시작하는지 검사

5.아이디로 검색 가능한지 검사

6.메일주소 형식에 맞는지

7휴대폰 번호 형식에 맞는지 검사

참고 reference

[정규 표현식 - JavaScript | MDN](https://developer.mozilla.org/ko/docs/Web/JavaScript/Guide/Regular_Expressions)
