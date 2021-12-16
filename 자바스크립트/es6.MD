# ES6 기능🐣

## es6 이전

> es6 이전 까지 자바스크립트의 함수는 별다른 구분 없이 다양한 목적으로 사용되었다.

<br>

1.자바스크립트의 함수는 일반적인 함수로서 호출 가능 **new**로도 호출하여 **인스턴스** 생성 한다.
<br>

2.객체에 **바인딩**되어 호출할수도 있다.

### es5 코드🐣

---

```javascript
var foo = function () {
  return 1;
};

//일반적인 함수로써 호출

foo();

//생성자 함수 호출
new foo(); //-> foo{}

//메서드로서 호출
var obj = { foo: foo };
obj.foo();
```

이처럼 es6 이전의 함수는 사용목적에 따라 구분되어 있지가 않다

즉 es6이전에 모든 함수는 일반 함수로서 호출할 수 있는 것은 물론 생성자 함수로서 호출도 가능하다⇒ es6이전의 함수는 모두 **callble**이며 **construtor** 이다.

```jsx
var foo = function () {};

//es6이전의 모든 함수는 callable 이며 construotor이다
foo(); // undifined
new foo(); // ->foo{}
```

**1.callbale**:호출 가능한 객체를 callable

**2.consturct**:인스턴스를 생성할 수 있는 함수 객체를 constructor

**3.non-consturct**:인스턴스 생성 못하는거 non-constructor

주의할 것은 es6이전에 일반적으로 메서드라고 부르던 객체에 바인딩된 함수도 **callable** 이며 **constructor**라는 것이다.

따라서 객체에 바인딩된 함수도 일반 함수로서 **호출**할 수 있는 것은 물론 **생성자 함수**로도 호출가능

```jsx
//프로퍼티 f 에 바인딩된 함수는 callable이며 constructor 이다

var obj = {

x:10,
f: function() {return this.x;}
}

console.log((obj.f));
//프로퍼티 f에 바인딩된 함수를 메서드로서 호출
var bar = obj.f;
console.log((bar));

//프로퍼티 f 에 바인딩된 함수를 일반 함수로서 호출

//프로퍼티f에 바인딩딘 함수를  생성 함수로써 호출
console.log(new.obj.f()); //f{}
```

위 예제와 같이 객체에 바인딩된 함수를 생성자 함수로 호출하는게 문법상 가능하다는 문제가 있다

constructor라는 것은 property와 프로로타입 객체도 생성할수 있는 의미를 가짐

콜백함수 또한 이런 문제를 가지고 있다.

#### **콜백함수의 문제**

---

```jsx

//콜백 함수를 사용하는 map 콜백함수도 constructor라서 프로토타입 생성됨
[1,3,2].map(function(item){
	return item*2;
}
```

이처럼 ES6 이전의 모든 함수는 사용 목적에 따라 명확한 구분이 없으므로 호출 방식에 특별한 제약이 없고 생성자 함수로 호출되지 않아도 프로토타입 객체를 생성한다.

| ES6 함수 | constructor | prototype | super   | argument |
| -------- | :---------- | :-------- | :------ | :------- |
| 일반함수 | 내용 2      | 내용 3    | 내용    | 4내용    |
| 메서드   | 내용 6      | 내용 7    | 내용 8  | 내용     |
| 화살표   | 내용 10     | 내용 11   | 내용 12 | 내용     |

일반 함수는 함수 선언문이나 함수 표현식으로 정의한 함수를 말하며 ES6 이전의 함수와 차이가 없다

하지만 메서드랑 화살표 함수는 차이가 있다.

### 메서드

ES6 이전 사양에는 메서드에 대한 명확한 정의가 없었다. 일반적으로 메서드는 객체에 바인딩된 함수를 일컫는 의미로 사용됨 ES6 에서는 메서드에 대한 정의가 명확하게 규정되었다 ES6사양에서 메서드는 **메서드 축약 표현**으로 정의된 함수만 가르킨다.

```jsx
const obj = {
x:1

//foo 메서드다
foo(){return this.x;}
bar: function(){return this.x};
//bar는 일반 함수이다.
}
};

console.log(obj.foo());  //1
console.log(obj.bar());  //1

```

es6 사양에서 정의된 메서드는 **인스턴스**를 생성할 수 없는 거다.

그래서 es6에선 foo는 인스턴스를 생성할수 없고 prototype 프로퍼티가 없고 프로토타입도 생성하지 않는다.

```jsx
obj.foo.hasOwnPrototype('prototype'); //false

obj.bar.hasOwnProperty('prototyle") //true
```

빌트인 객체에서 제공하는 정적 메서드도 **non-constructor**이다

ES6메서드는 자신을 바인딩한 객체를 가르키는 내부슬롯 [[homeObject]]를 가진다

homeobject는 super키워드 사용가능 **⇒** 정적 메서드만 사용 가능하게 바뀜

### 화살표 함수

화살표함수는 function 키워드 대신 ⇒로 사용하여 기존 함수 정의한느것을 간략하게 정의할수 있게 만들어줬다.

**화살표 함수 정의**

함수정의

const multiply = (x,y) ⇒ x\*y;

multiply(2,3) //6

매개변수정의

const arr = (x,y) ⇒ {...}; = 매개변수 여러개일떄 ()로 매개변수 선언

const arr = x⇒ { ...}; = 매개변수 한 개일 경우 () 생략가능

const arr () ⇒ {...}; = 매개변수가 없는 경우 소괄호 생략가능

함수 몸체 정의

```jsx
const arr = () => const x=1; // ?

const arr = () => {return const x=1;}; //?
```

**객체 리터널 반환하는** 경우 객체 리터널 () 감싸줘야함

```jsx
const create = (id,content) => ({id,content});
create(1,'javacret's);

const create = (id,content) => {return {id,content};};

```

소괄호를 감싸지 않으면 중괄호를 함수 몸체를 감는 중괄호로 암

```jsx
const create = (id,content) => {id,content};
creaet(1.'javasrcipt');
```

함수 몸체가 여러 개 문으로 굿어되면 중괄호{} 생략 불가능 이떄 반환값이 있으면 return 써줘야함

```jsx
const sum = (a, b) => {
  const result = a + b;
  return result;
};
```

화살표 함수는 즉시 실행 함수로 사용할수 있다.

```jsx
const person = (name =>({
 sayHi() {return `hi my name is${name}.`;}
})))('lee');

console.log(person.sayHi()); //hi my name is lee
```

고차함수 의 경우도 화살표 함수를 쓰면 더 간결하고 가독성이 좋아보인다

```jsx
[1, 2, 3].map((v) => v * 2);
[2, 4, 6];
```

화살표 함수와 일반 함수의 차이

1.화살표 함수는 인스턴스를 생성할 수 없는 non-construtor이다

prototype프로퍼티도 없다

```jsx
const foo = () => {}; //화살표 함순는 인스턴스 생성못해요!
new Foo();
```

2..중복한 매개변수 이름을 선언할 수 없다

```jsx
function nornal(a,a) {return a+a};
console.log(1,2));  //?

const arrow = (a,a) => a+a;  //오류
```

3.화살표 함수는 this argument super new target 할당 못받음

## this

화살표 함수는 다른 함수의 인수로 전달되어 콜백 함수로 사용하는 경우가 많다

this 바인딩은 함수가 어떻게 호출되엇나에 따라 동적으로 결정됨

**화살표 함수는 this의 바인딩을 갖지 않는다 따라서 함수 내부에서 this를 참조해도**

**일반함수처럼 undifined가 나온느게 아니라 상위 스코프 this를 참조 받는다**

```jsx
class Prefixer {
  constructor(prefix) {
    this.prefix = prefix;
  }

  add(arr) {
    // add 메서드는 인수로 전달된 배열 arr을 순회하며 배열의 모든 요소에 prefix를 추가한다.
    // ①
    return arr.map(function (item) {
      return this.prefix + item; // undifined
      // -> TypeError: Cannot read property 'prefix' of undefined
    });
  }
}

const prefixer = new Prefixer("-webkit-");
console.log(prefixer.add(["transition", "user-select"]));
```

일반 함수에서 호출되는 모든 함수 내부의 this는 전역 객체를 가르킨다.

그러나 클래스 내부의 모든 코드는 엄격 모드(static mode)가 적용 되어 있다.

es6전에선 이런 문제를 해결하기 위해서

반환 전 this를 다른 값으로 옮기기

map에 두번 째 인수로 add 메서드를 호출한 prifiexer 객체 가르키는 this 전달

### this 전달 방법

```javascript
add(arr) {

return arr.map(function (item) {
return this.prefix + item;
}, this);

prototype.bind메서드 써서 this 값 바인딩

es6에서는 화살표 함수 이용해서 this 문제 해결 방법
```

```jsx
class Prefixer {
  constructor(prefix) {
    this.prefix = prefix;
  }

  add(arr) {
    return arr.map((item) => this.prefix + item);
  }
}

const prefixer = new Prefixer("-webkit-");
console.log(prefixer.add(["transition", "user-select"]));
// ['-webkit-transition', '-webkit-user-select'] 나옴
```

이런 이유는 화살표 함수는 **this 바인딩**이 존재하지 않기 때문이다

화살표 함수는 bind함수를 표현하는 방식과 같다!

화살표 함수가 중첨된 경우는 가장 가까운 상위 함수의 this 참조한다.

**super,arguments**

this 랑 같이 참조하면 상위 클래스 참조한다.

## REST 파라미터

**rest는 함수에 전달된 인수들의 목록을 배열로 전달 받는다**

```jsx
function foo(...rest) {
  // 매개변수 rest는 인수들의 목록을 배열로 전달받는 Rest 파라미터다.
  console.log(rest); // [ 1, 2, 3, 4, 5 ]
}

foo(1, 2, 3, 4, 5);
```

rest는 이름 그대로 먼저 선언된 매개변수에 할당된 인수를 제외한 나머지 인수들로 구성된 배열로 할당된다 따라서 **rest 파라미터는 맨뒤에 있어야함**

**rest는 단 하나만 선언가능**

```jsx
function foo(param, ...rest) {
  console.log(param); // 1
  console.log(rest); // [ 2, 3, 4, 5 ]
}

foo(1, 2, 3, 4, 5);

function bar(param1, param2, ...rest) {
  console.log(param1); // 1
  console.log(param2); // 2
  console.log(rest); // [ 3, 4, 5 ]
}

bar(1, 2, 3, 4, 5);
```
