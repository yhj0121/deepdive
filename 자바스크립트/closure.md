### 클로저

클로저는 자바스크립트 고유의 개념이 아님 함수를 일급 객체로 취급하는 함수형 프로그래밍 언어 에서 사용되는 중요한 특성

클로저는 함수와 그 함수가 선언된 렉시컬 환경과의 조합이다.

```jsx
const x =1;

function outerFunc()
{
 const x=10;
function innerFunc(){
console.log(x);  //10

}

innterFunc();
}

outerFunc();
```

outer 함수 내부에서 중첩 함수 inner 있어서 x변수 접근 가능

내부에 없으면 1로 값이 찍힘

### 렉시컬 스코프

자바스크립트 엔진은 함수를 어디서 호출햇는지가 아니라 어딧 ㅓ정의햇는지에 따라 상위 스코프를 결정한다 이를 렉시컬 스코프(정적 스코프)라고한다

렉시컬 환경의 외부 렉시컬 환경에 대한 참조에 저장할 참조값 즉 상위 스코프에 대한 참조는 함수 정의가 평가되는 시점에 함수가 정의된 환경에 의해 결정

### 함수 객체의 내부 슬록[[environment]]

함수가 정의된 환경과 호출되는 환경은  다를수 있어서 상위 스코프를 기억해야 한다. 이를 위해 함수는 내부슬롯에 자신이 정의된 환경 상위 클래스의 참조를 저장한다.

```jsx
const x =1;

function outer() {
const x=10;
const inner = function(){console.log(x);};
return inner;
}

//outer 함수를 호출하면 중첩함수 inner를 반환한다
//그리고 outer 함수의 실행 컨텍스트는 실행 컨텍스트 스택에서 팝되어 제거된다.

const innerFunc = outer();

innerFunc();
```

outer값은 호출하면 inner 반환하고 생명주기 마감되면서 pop되는데 x 10의 값을 가져올수 있다. 이처럼 외부함수보다 중첩함수가 더 오래 유지되는 경우 중첩함수는 이미 생성 주기가 종료한 외부 함수의 변수를 참조할 수 있다. 이러한 중첩 함수 클로저 라고한다.

outer 끝나면 소멸해야하지만 inner 참조중이라 가비지 컬렉션 대상이 안됨

상위 스코프의 어떤 식별자도 참조하지 않는 함수는 클로저가 아님

상위 스코프 식별자도 참조하고 일찍 소멸 하면 안됨

**클로저는 중첩 함수가 상위 스코프의 식별자를 참조하고 있고 중첩 함수가 외부 함수보다 더 오래 유지하는 경우에 한정되는 것이 일반적** 

상위 스코프 변수를 자유 변수라함

### 클로즈의 활용

클로저는 상태를 더 안전하게 변경하고 유지하기 위해서 사용 

상태를 안전하게 은닉하고 특정 함수에게만 상태 변경 허용

```jsx
let num =0;

const increase = function(){
return ++num;
};

console.log(increase());
console.log(increase());
console.log(increase());
```

1카운트 상태는  increase함수가 호출되기 전까지 변경되지 않고 유지 되어야 함

2.이를 위해 카운트 상태는 increase 함수만이 변경 가능해야함

 

```jsx
const increase = function(){
let num =0;
return ++num;
}
console.log(increase()); //이전 상태 유지 못함

console.log(increase());
console.log(increase());

```

카운트 상태를 안전하게 변경하고 유지하기 위해 전역 변수 num을 increase의 지역 변수로 변경하여 의도치 않는 변경 방지 했지만 num은 0으로 계쏙 초기화되기 떄문에 출력 결과는 언제나 1이다.

```jsx
const increase = (function() {
//카운터 변수 함수
let num=0;

//ㅋ클로저
return function(){
//카운터 상태를 1만큼 증가시킨다
return ++num;
}
}());
```

위 코드가 실행되면 즉시 실행함수 호출되고 즉시 실행 함수가 반환한 함수가 increase 변수에 할당된다

increase변수에 할당된 함수는 자신이 정의된 위치에 의해 결정된 상위 스코프인 즉시 실행함수의 렉시컬 환경을 기억하는 **클로저 즉시실행함수 렉시컬 환경 알고있다.**

이처럼 클로저는 상태가 의도치 않게 변경되지 않도록 안전하게 은닉하고 특정 함수에게만 상태 변경을 허용하여 상태를 안전하게 변경하고 유지 가능하게함

**즉시 실행 함수를 반환하는 객체 리터널**

```jsx
const counter =(function(){
let num =0;

//클로저
//객체 리터럴은 스코프를 만들지 않는다
//따라서 아래 메서드들의 상위 스코프는 즉시 실행 함수의 랙세컬 환경이다

return {
//num:0 //프로퍼티는 public 하니까 은닉되지 않음
increase(){
return num++;
},
decrease(){
	return num>0? --num: 0;
}
};
}());

console.log((counter.increase());
console.log((counter.increase());
console.log((counter.decrease());
console.log((counter.decrease());

```

생성자 함수로 표현하기

```jsx
const counter =(function(){
let num =0;

//클로저
//객체 리터럴은 스코프를 만들지 않는다
//따라서 아래 메서드들의 상위 스코프는 즉시 실행 함수의 랙세컬 환경이다

function Counter(){
//this.num=0; //2 프로퍼티는 public하므로 은닉하지 않음
}

Counter.prototype.increase = function (){
	return ++num;
};

Counter.prototype.decrease= function (){
	return num >0? --num: 0;
};

return Counter;
}());

const counter = new Counter();
console.log((counter.increase());
console.log((counter.increase());
console.log((counter.decrease());
console.log((counter.decrease())
```

```jsx
//함수를 인수로 전달 받고 함수를 반환하는 고차 함수
//이 함수의 카운트 상태를 유지하기 위한 자유 변수 counter를 기억하는 클로저를 반환한다.
function makeCounter(predicate){
//카운터 상태를 유지하기 위한 자유 변수
let counter =0;

// 클로저를 변환
return function(){

// 인수를 전달 받은 보조 함수에 상태 변경을 위임한다.
counter = predicate(counter);
return counter;

};
}

//보조 함수
function increase(n){
	return ++n;
}

function decrease(n){
	return --n;
}

//함수로 함수를 생성한다.
//makeCounter 함수는 보조 함수를 인수로 전달받아 함수를 변환한다.

const increase = makeCounter(increase);
// 보조 함수를 전달하여 호출
console.log(increase));
console.log(increase));

const decrease = makeCounter(decrease);
console.log(decrease));
console.log(decrease));

```

makeCounter 함수를 호출해 함수를 반환할 때 반환된 함수는 자신만듸 독립된 렉시컬 환경을 갖는다.

makeCounter 함수 환경 참조되고 있기 떄문에 소멸되지 않는다.

### 캡슐화와 정보 은닉

캡슐화는 객체의 상태를 나타내는 프로퍼티와 프로퍼티를 참조하고 조작할수 있는 동작인 메서드를 하나로 묶는 것을 말한다. 캡슐화는 객체의 특정 프로퍼티나 메서드를 감출 목적으로 사용하는데 이를 정보 은닉 이라고 한다!

```jsx
function Person(name,age)
{
this.name = name; //public
let _age = age; //private

this.sayHi = function(){
 console.log(`hi my name is${this.name}. i am ${_age}.`);

};
}

const me = new Person('lee',20);
me.sayHi(); // hi my name is lee i am 20;

console.log(me.name); //lee
console.log(me._age); //undifiend //지역 변수라 안나옴

```

```jsx
const Person = (function() {{
this.name = name; //public
let _age = age; //private
}

Person.prototype.sayHi = function(){
 console.log(`hi my name is${this.name}. i am ${_age}.`);

};

//생성자 함수 편환
return Person;
}());
```

생성자 함수는 이런식으로 한다.

하짐나 여러개의 인스턴스 쓸떄는 _age 같이 유지디지 않음

프로토타입 메서드는 상위 스코프에 저장해야하는데 sayhi는 동일한 상위 스코프를 사용하기 때문에 _age 의 변수 사태가 유지안됨 ㅠ

### 자주 발생하는 실수

아래는 클로저를 사용할 때 자주 발생할 수 있는 실수

```jsx
var func = [];

for(var i=0; i<3; i++) {
 func[i] = function(){return i};
}

for(var j=0; j<func.length; j++)
{
console.log(func[j);
}
```