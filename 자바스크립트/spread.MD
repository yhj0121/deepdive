### 스프레드 문법이란?🙄

스프레드 문법은 ...은 하나로 뭉처 있는 여러 값들의 집합을 펼쳐서 개별적인 값들의 목록으로 바꾼다.

스프레드 문법 사용할수 있는 대상은?🐏

Array   SET String Map Dom

for...of문으로 순회 가능한 이터러블만 한정

스프레드 **코드**

```jsx
// ...[1, 2, 3]은 [1, 2, 3]을 개별 요소로 분리한다(→ 1, 2, 3)
console.log(...[1, 2, 3]); // 1 2 3

// 문자열은 이터러블이다.
console.log(...'Hello'); // H e l l o

// Map과 Set은 이터러블이다.
console.log(...new Map([['a', '1'], ['b', '2']])); // [ 'a', '1' ] [ 'b', '2' ]
console.log(...new Set([1, 2, 3])); // 1 2 3

// 이터러블이 아닌 일반 객체는 스프레드 문법의 대상이 될 수 없다.
console.log(...{ a: 1, b: 2 });
// TypeError: Found non-callable @@iterator
```

스프레드 코드의 특징

일반함수엔 사용 못함

스프레드 결과는 변수에 할당하는건 불가능하다.

스프레드 결과는  밑에 잇는 목록에만 사용 가능하다.

- **함수 호출문의 인수 목록**
    
    ```jsx
    const arr = [1,2,3];
    
    // 배열 arr중 요소의 최대 값을 얻기 위해
    Math.max사용한다.
    
    const max = Math.max(arr); // Nan이다.
    
    //es5에선 apply사용
    
    var max = Math.max.apply(null,arr) //3
    ```
    

Math max는 매개변수를 확정할수 없는 가변 인자 함수

이를 해결하기 위하여 스프레드 문법 사용가능

```jsx
const arr = [1,2,3];

const max = Math.max(...arr) //3

```

- **REST 파라미터랑 비슷한 스프레드 문법**
    
    REST랑 형태가 동일하여 혼동할수 있지만
    
    Rest는 함수에 **전달된 인수들의 목록을 배열로** 받기위함
    
    스프레드는 여러 개의 값을 하나로 뭉쳐 있는 배열과 같은 이터러블 펼쳐서 **개별적인 값 목록** 만드는것
    

- **배열 리터럴 요소 목록**
    
    
    1.const
    
    ```jsx
    const arr [...[1,2], ...[3,4]];
    console.log(arr) //[1,2,3,4];
    ```
    
    2.splice
    
    es5에서 배열 추가 제거하기 위해서 splice 메서드 사용한다.
    
    이때 splice메서드의 세번쨰 인수로 배열을 전달하면 배열 자체에 추가된다
    
    이때 스프레드 문법을 쓰면 깔끔하게 전달된다
    
    ```jsx
    cosnt arr1=[1,3]
    const arr2=[2,4]
    
    arr1.splice(1,0...arr2);
    console.log(arr1); //[1,2,3,4]
    ```
    
    3.배열 복사
    
    스프레드 문법을 쓰면 배열 복사가 더 간결하게 된다
    
    ```jsx
    const origin = [1,2];
    const copy[...origin];
    ```
    

4.이터러블 배열로 변환

function.prototype.apply call 메서드를 안쓰고도 변환 가능

```jsx
function sum(){
	
return[...arguments].reduce((pre,cur) => pre + cur,0);
}

console.log(sum(1,2,3,)); //6
```

하지만 이터러블 아닌 유사 배열 객체는 스프레드 사용하지 못한다

- **객체 리터널의 프로퍼티 목록**
    
    
    ```jsx
    // 스프레드 프로퍼티
    // 객체 복사(얕은 복사)
    const obj = { x: 1, y: 2 };
    const copy = { ...obj };
    console.log(copy); // { x: 1, y: 2 }
    console.log(obj === copy); // false
    
    // 객체 병합
    const merged = { x: 1, y: 2, ...{ a: 3, b: 4 } };
    console.log(merged); // { x: 1, y: 2, a: 3, b: 4 }
    ```
    
    2021년부터 객체 리터널도 스프레드 프로퍼티사용가능
    
    스프레드 제안전엔 object.assign 메서드 사용했다
