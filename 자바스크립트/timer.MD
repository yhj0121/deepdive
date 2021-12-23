## 호출 스케줄링

---

함수를 명시적 호출하면 함수 즉시 실행 가능하지만 함수를 명시적으로 호출하지 않고 타이머 함수를 사용하면 호출 예약이 가능하다 이를 호출 스케줄링 이라고 한다

자바스크립트 엔진은 단 하나의 실행 컨텍스트를 가지는 싱글 스레드 구조기 때문에 타이머 함수 **setInterval setTimeout등은 비동기 처리로 동작한다.**

## 타이머 함수

---

### setTimeout/clearTimeout

**1.setTimeout**

setTimeout 함수는 두번째 인수로 전달받은 시간으로 단 한 번 동작하는 타이머로 타이머가 만료되면 첫번째 인수로 전달받은 콜백 함수 호출한다.

<aside>
💡 const timeoutId = setTimeout(fun|code[, delay,param1,param2]);

</aside>

func:타이머가 만료된 뒤 호출될 콜백함수

delay:타이머 만료 시간 생략시 기본값 0으로 지정됨

param: 호출 스케줄링된 콜백 함수에 전달해야 할 인수가 졸재할 경우 세번째 이후의 인수로 전달 가능

```jsx
setTimeout((name) => console.log(`Hi! ${name}.`), 1000, "Lee");
```

**2.clearTimeout**

**setTimeout** 함수가 반환한 타이머 id를 **clearTimeout**함수의 인수로 전달해 타이머를 취소할 수 있다.

```jsx
const timerId = setTimeout(() => console.log("Hi!"), 1000);

clearTimeout(timerId);
```

타이머가 취소되면 **setTimeout** 함수의 콜백 함수가 실행되지 않는다.

### setInterval/clearInterval

---

**setinterval**

setinverval함수는 두번째로 전달받은 시간으로 반복 동작하는 타이머 생성 하고 식별할 수 있는 고유한 타이머 id를 반환한다. 타이머 id는 브라우저 환경인 경우에는 숫자이고 Node.js 환경인 경우에는 객체다.

**clearInterval**

함수 스케줄링 취소 가능함

## 디바운스 스로롤

---

디바운스와 스로틀은 잛은 시간 연속해서 발생하는 이벤트를 구릅화 해서 과도한 이벤트 핸들러 호출을 방지하 것이다.

### 디바운스란?

> 디바운스는 짧은 시간 간격으로 이벤트를 연속으로 발생하면 이벤트 핸들러 호출하지 않다가 일정 시간이 경과한 이우헤 이벤트를 한번만 호출하게 함

### 스로틀은?

> 짧은 시간 간격으로 이벤트가 연속해서 발생하더라도 일정 시간 간격으로 이벤트 핸들러가 최대 한 번만 호출되도록 한다. 즉, 짧은 시간 간격으로 연속해서 발생하는 이벤트를 그룹화해서 일정 시간 단위로 이벤트 핸들러가 호출되도록 호출 주기를 만든다.

## 디바운스 vs 스로틀

디바운스는 delay기간+input이 있는지에 따라 다르고

스로틀은 delay시간이 끝나면 콜백을 반환한다.

## 동기처리와 비동기

---

실행컨텍스트 함수 컨텍스트는 푸쉬하고 팝이 이루어짐

자바스크립트는 싱글 스레드라 하나당 단 하나의 실행 컨텍스트 스택밖에 가질수가 없다.

```jsx
// sleep 함수는 일정 시간(delay)이 경과한 이후에 콜백 함수(func)를 호출한다.
function sleep(func, delay) {
  // Date.now()는 현재 시간을 숫자(ms)로 반환한다.("30.2.1. Date.now" 참고)
  const delayUntil = Date.now() + delay;

  // 현재 시간(Date.now())에 delay를 더한 delayUntil이 현재 시간보다 작으면 계속 반복한다.
  while (Date.now() < delayUntil);
  // 일정 시간(delay)이 경과한 이후에 콜백 함수(func)를 호출한다.
  func();
}

function foo() {
  console.log("foo");
}

function bar() {
  console.log("bar");
}

// sleep 함수는 3초 이상 실행된다..
sleep(foo, 3 * 1000);
// bar 함수는 sleep 함수의 실행이 종료된 이후에 호출되므로 3초 이상 블로킹된다.
bar();
// (3초 경과 후) foo 호출 -> bar 호출
```

동기처리하면 이처럼 다음테스크가 블록킹(작업중단)이됨

```jsx
function foo() {
  console.log("foo");
}

function bar() {
  console.log("bar");
}

// 타이머 함수 setTimeout은 일정 시간이 경과한 이후에 콜백 함수 foo를 호출한다.
// 타이머 함수 setTimeout은 bar 함수를 블로킹하지 않는다.
setTimeout(foo, 3 * 1000);
bar();
// bar 호출 -> (3초 경과 후) foo 호출
```

**하지만 비동기 함수(settimeout setTinterval Http 요청 이벤트 핸들러)등을 이용하면 블록킹이 발생 되지 않는다.**

## 이벤트 루프와 태스크 큐

---

**이벤트 루프**는 자바스크립트가 내장중인 기능 중 하나로 콜 스택 힙을 이용하여 브라우저가 동시에 처리되는거처럼 만들수가 있다.

콜스택:소스코드 평가 과정에서 생성된 실행 컨텍스트가 추가되고 제거되는 스택이(실행컨텍스트 스택) 바로 콜스택이다.

힙:객체 저장하는 메모리 공간 콜스택의 요소인 실행컨텍스트는 힙에 저장된 객체 참조해야함.

**브라우저는 자바스크립트 엔진 외에도 렌더링 엔진과 Web API를 제공하는데, Web API에는 DOM API와 타이머 함수, HTTP 요청(Ajax)과 같은 비동기 처리를 포함한다.**

> 비동기 처리에서 소스코드의 평가와 실행을 제외한 모든 처리는 자바스크립트 엔진을 구동하는 환경인 브라우저/Node.js가 담당한다. 브라우저는 멀티 스레드 방식으로 동작한다.

🧩 **태스크 큐(task queue/event queue/callstack queue)**비동기 함수의 콜백 함수나 이벤트 핸들러가 일시적으로 보관되는 영역이다.

🧩 **이벤트 루프(event loop)**콜 스택에 현재 실행 중인 실행 컨텍스트가 있는지, 태스크 큐에 대기 중인 함수가 있는지 반복해서 확인한다. 만약 콜 스택이 비어 있고 태스크 큐에 대기 중인 함수가 있다면, 이벤트 루프는 순차적으로 태스크 큐에 대기 중인 함수를 콜 스택에 이동시킨다.

```jsx
function foo() {
  console.log("foo");
}

function bar() {
  console.log("bar");
}

setTimeout(foo, 0); // 0초(실제는 4ms) 후에 foo 함수가 호출된다.
bar();
```
