### 심벌은?

> 심벌은 es6에 도입된 7번쨰 값으로 변경 불가능한 원시 타입의 값이다. 심벌 값은 다른 값과 중복되지 않는 유일무이한 값

### 심벌 값의 생성

1.symbol함수

심벌값은 symbol 함수를 호출하여 생성하다 다른 원시값 즉 문자열 숫자 불리언 undifined null 타입의 값은 리터널 표기법을 통해 값을 생성할 수 있지만 심벌 값은 symbol함수를호출하여 생성해야 한다

**다른 값과 중복되지 않는 유일한 값이다.**

```jsx
// Symbol 함수를 호출하여 유일무이한 심벌 값을 생성한다.
const mySymbol = Symbol();
console.log(typeof mySymbol); // symbol

// 심벌 값은 외부로 노출되지 않아 확인할 수 없다.
console.log(mySymbol); // Symbol()
```

\*다른 생성자함수와의 차이

symbol 함수는 선택적으로 문자열을 인수로 전달 할 수 없다

이 문자열은 생성된 심벌 값에 대한 설명으로 디버깅 용도로만 사용되며, 심벌 값 생성에 어떠한 영향도 주지 않는다.

즉 심벌 값에 대한 설명이 같더라도 생성된 심벌 값은 유일무이한 값이다.

```jsx
new Symbol(); // TypeError: Symbol is not a constructor

// 심벌 값에 대한 설명이 같더라도 유일무이한 심벌 값을 생성한다.
const mySymbol1 = Symbol("mySymbol");
const mySymbol2 = Symbol("mySymbol");

console.log(mySymbol1 === mySymbol2); // false
```

십벌 값도 문자열 숫자 불리언과 같이 객체에 접근하면 암묵적으로 래퍼 객체를 생성한다.

```jsx
const mySymbol = Symbol("mySymbol");

// 심벌도 레퍼 객체를 생성한다
console.log(mySymbol.description); // mySymbol
console.log(mySymbol.toString()); // Symbol(mySymbol)
```

심벌 값은 암묵적으로 문자열이나 숫자 타입으로 변환하지 않는다.

```jsx
const mySymbol = Symbol();

// 심벌 값은 암묵적으로 문자열이나 숫자 타입으로 변환되지 않는다.
console.log(mySymbol + ""); // TypeError: Cannot convert a Symbol value to a string
console.log(+mySymbol); // TypeError: Cannot convert a Symbol value to a string
```

하지만 불리언 값은 암묵적으로 타입 변환한다.

if 문을 통해 존재 확인이 가능.

### symbol.for/symbol.keyFor 메서드

### symbol.for

**symbol.for**메서드는 인수로 전달받은 문자열을 키로 사용하여 키와 심벌 값의 쌍들이 저장되어 있는 전역 심벌 레지스트리에서 해당 키와 일치하는 심벌 값을 검색한다.

- 검색에 성공하면 새로운 심벌 값을 생성하지 않고 검색된 심벌 값을 반환한다.

- 검색에 실패하면 새로운 심벌 값을 생성하여 symbol.for 메서드의 인수로 전달된 키로 전역 심벌 레지스트리에 저장한 후 생성된 심벌 값을 반환한다.

```jsx
// 전역 심벌 레지스트리에 mySymbol이라는 키로 저장된 심벌 값이 없으면 새로운 심벌 값을 생성
const s1 = Symbol.for("mySymbol");
// 전역 심벌 레지스트리에 mySymbol이라는 키로 저장된 심벌 값이 있으면 해당 심벌 값을 반환
const s2 = Symbol.for("mySymbol");

console.log(s1 === s2); // true
```

**symbol.keyFor**

심벌 저장소에 저장된 심벌 값의 키를 출력 가능

```jsx
// 전역 심벌 레지스트리에 mySymbol이라는 키로 저장된 심벌 값이 없으면 새로운 심벌 값을 생성
const s1 = Symbol.for("mySymbol");
// 전역 심벌 레지스트리에 저장된 심벌 값의 키를 추출
Symbol.keyFor(s1); // -> mySymbol

// Symbol 함수를 호출하여 생성한 심벌 값은 전역 심벌 레지스트리에 등록되어 관리되지 않는다.
const s2 = Symbol("foo");
// 전역 심벌 레지스트리에 저장된 심벌 값의 키를 추출
Symbol.keyFor(s2); // -> undefined
```

### 심벌과 상수

상수의 값이 변경되는걸 막기 위해선 symbol값을 사용한다.

### 심벌과 프로퍼티 키

객체의 프로퍼티 키는 빈문자열 포함하는 모든 문자열 또는 심벌 값으로 만들수 있고 동적 생성 가능

심벌 값을 프로퍼티 키로 사용하러면 심벍밧에 대괄호를 사용해야한다 프로퍼티 접근할 떄도 대괄호 사용해야한다.

심벌값은 유일무이한 갑승로 심벌 값으로 프로퍼티 키를 만들면 다른 프로퍼티 키와 절대 충돌하지 않는다.

심벌 값을 프로퍼티 키로 사용하여 생성한 프로퍼티는 for in object keys object getOwnpropertyname 같은걸로 찾을수 없다.

### 심벌과 표준 빌트인 객체 확장

심벌은 일기전용으로만 사용한느것이 좋다
