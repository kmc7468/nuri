# 🗺️ 누리

누리는 쓰기 쉬운 함수형 한글 프로그래밍 언어입니다.

```
"안녕, "과 "세상!" 연결하고 보여주다
```

## 특징

누리의 주된 언어 방향성은 **함수형 프로그래밍 언어** 입니다. 그에 따라 대부분의 언어적 특징은 함수에서 나옵니다.

### 조사

누리에서 함수의 정의는 다음과 같은 방식으로 합니다.

```lua
동사 [ㄱ]을 [ㄴ]으로 나누다: [ㄱ] / [ㄴ]
```

이 코드를 통해서 "ㄱ"과 "ㄴ" 이라는 인자를 받는 "나누다"라는 함수(동사)를 정의했습니다. 그리고 이 함수를 호출하면 "ㄱ"을 "ㄴ"으로 나눈 값을 반환합니다.

함수의 호출은 다음과 같이 합니다.

```lua
10을 5로 나누다
```

다른 언어로 치면 `divide(10, 5)` 와 비슷한 코드입니다. 그런데 누리에는 다른 점이 하나가 있는데, 바로 함수를 호출할 때 인수 뒤에 **조사**를 붙인다는 것입니다. 위 코드의 `10을 5로` 에서 '을'과 '로'가 조사에 해당합니다.

한국어는 조사의 존재로 인해 문장 내에서 어순을 바꾸어도 의미가 달라지지 않는다는 특성을 갖고 있습니다. 누리는 이를 활용해서, 함수를 호출할 때 **인수의 위치를 바꾸어도 조사에 맞는 위치에 인수를 집어넣도록 하는 기능**을 넣었습니다. 즉,

```lua
10을 5로 나누다 == 5로 10을 나누다 == 2
```

입니다. 추가적으로 조사는 이름있는 인수(named arguments)와 비슷한 역할을 하여 인수의 의미를 조금 더 명확하게 해준다는 장점 또한 있습니다.

### 함수의 품사 (동사, 형용사)

누리의 함수는 세 종류로 구분되며, 일반적인 함수, 동사, 형용사가 있습니다. 

일반적인 함수는 말 그대로 일반적인 함수입니다.

```lua
함수 [목록]의 합계:
	만약 [목록] == {} 이라면 0
  아니라면 [목록]의 첫번째 + ([목록]의 나머지)의 합계
```

동사는 `~(하)다` 의 꼴로 생긴 함수이며, **연쇄 호출을 할 수 있다**는 특징이 있습니다.

```lua
동사 [ㄱ]을 [ㄴ]으로 나누다: [ㄱ] / [ㄴ]
동사 [ㄱ]과 [ㄴ]을 더하다: [ㄱ] + [ㄴ]
```

이렇게 `나누다` 라는 동사와 `더하다` 라는 동사들을 선언합니다. 그러면 다음과 같이 사용이 가능합니다.

```python
10을 5로 나누고 출력하다 # 출력: 2
2와 8을 더하고 5로 나누고 출력하다 # 출력: 2
```

이렇게 동사는 조금 더 "자연어"스러운 코드의 활용이 가능합니다. `(10을 5로 나누다)를 보여주다` 와 같은 코드보다는 가독성이 좋다는 것을 알 수 있습니다.

형용사는 어떤 값의 특징을 판정하는 함수이고, 동사와 비슷하게 `~다` 의 꼴로 생긴 함수입니다.

```python
형용사 [ㄱ]과 [ㄴ]이 같다: [ㄱ] == [ㄴ]
```

현재는 별다른 활용이 없지만, 근 시일 내에 특정 형용사에 대해 반의어, 유의어를 정의할 수 있는 기능을 추가할 예정입니다.

### 부분 호출 (Partial Application)

누리는 함수형 프로그래밍 언어의 대표적인 기능인 부분 호출(관점에 따라서는 커링으로도 볼 수 있습니다)을 지원합니다. 즉,

```lua
동사 [ㄱ]과 [ㄴ]을 더하다: [ㄱ] + [ㄴ]
```

와 같은 함수가 정의되어 있으면,

```lua
5와 10을 더하다 == 15
10을 더하다 == (인수를 1개 받아서 거기에 10을 더하고 반환하는 함수)
```

입니다. 응용해보자면 다음과 같은 코드를 작성할 수 있습니다.

```lua
{1, 2, 3}에 (2를 더하다)를 각각_적용하다 == {3, 4, 5}
```

### 선언형 프로그래밍

누리는 함수형 프로그래밍 언어이자 **선언형 프로그래밍 언어**입니다. 명령형 프로그래밍 언어(C, Java, Python 등이 해당)는 프로그램이 무엇을 실행해야하는지 컴퓨터에게 지시하는 방식을 사용한다면, 선언형 프로그래밍 언어는   무엇이 무엇인지 정의해 나가면서 프로그래밍을 합니다. 즉, 선언형 프로그래밍 언어는 수학이 함수를 정의하는 방식과 조금 더 유사하다고 볼 수 있습니다.

선언형 프로그래밍 언어는 부수 효과(side effects)를 최대한 피한다는 특징이 있습니다. 이에 따라 누리에는 **변수가 없습니다.** 오직 상수만 존재합니다. (오해는 하시면 안됩니다! 변수가 없어도 재귀 함수 등을 이용하여 다른 프로그래밍 언어에서 작성할 수 있는 프로그램을 모두 구현할 수 있습니다.)

제가 명령형 패러다임이 아닌 선언형 패러다임을 선택한 이유는, 선언형 프로그래밍이 자연어에 조금 더 적합하기 때문입니다. 우리가 평소에 다른 누군가에게 어떤 개념을 설명할 때 "이런 생각을 해. 그 다음 이런 생각을 해."와 같이 설명을 하진 않습니다. "이것은 이거고, 이거는 이거야"와 같은 방식으로 정의를 해 나가면서 설명을 합니다. 전자가 명령형 프로그래밍이고, 후자가 선언형 프로그래밍입니다.

## 장점

### JIT (Just-In-Time)

누리는 [하늘](https://github.com/suhdonghwi/haneul)이라는 백엔드 가상 머신을 사용합니다. 하늘은 JIT 실행을 지원하며, 이를 통해서 굉장히 빠른 성능을 낼 수 있습니다. 정확한 퍼포먼스 측정은 해보지 않았지만, 대부분의 예시 코드에서 CPython보다 좋은 성능을 보여주었습니다.

## 기여

누리는 아직 완성 단계가 아니며, 정식 릴리즈 단계가 아닙니다. 풀 리퀘스트, 버그 보고 등 모든 형태의 기여를 환영합니다.