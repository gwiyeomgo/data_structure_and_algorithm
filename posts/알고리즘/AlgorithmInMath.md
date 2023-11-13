- 이진수 : 이진법에서 쓰는 숫자,1과 0  두 개의 숫자만 사용
  - 진법: 숫자를 표현하고 저장하는 규칙
  - 이진수에서 숫자는 비트 
  - 십진법 ex) 1452 = (1*10**3)+(4*10**2)+(5*10**1)+(2*10**0)
  - 이진법 ex) 이진법의1101  => (1*2**3)+(1*2**2)+(0*2**1)+(1*2**0) = 십진법의 13
             삽잔법 13 ->13%2 =몫 6 나머지 1 
                     -> 6%2 =몫 3 나머지 0 
                     -> 3%2 =몫 1 나머지 1
                     -> 1%2 =몫 0 나머지 1
                     -> 역순으로 1101 

- 비트 연산자 : 두개의 이진수로 이루어진 표현식에서 사용하는 연산자

# [피즈버즈](https://leetcode.com/problems/fizz-buzz/submissions/1095757318/) 
  - 1 부터 100까지의 숫자를 출력하는 프로그램을 만들때
  - 3의 배수라면 숫자 대신 Fizz 출력
  - 5의 배수라면 Buzz 를 출력
  - 3과 5의 공배수라면 FizzBuzz
  - 선형 시간 복잡도
```
func fizzBuzz(n int) []string {
    results := make([]string,0)
    for i := 1; i <= n; i++ {
        result :=""
        if i%3 == 0 && i%5 == 0 { 
            result +="FizzBuzz"
        } else if i%3 == 0 {
            result +="Fizz"
        } else if i%5 == 0 {
            result +="Buzz"
        } else {
            result +=  strconv.Itoa(i)
        }
        results = append(results,result)
    }
    
    return results
}
```


# [최대공약수](https://www.acmicpc.net/problem/1934)
두 개 이상의 정수를 나누어떨어지게 하는 가장 큰 양의 정수

20 과 12 의 공약수 1,2,4. 가장 큰 숫자 4 가 최대공약수
20의 약수 1 2 4 5 10
12의 약수 1 2 3 4 6

두 숫자를 나머지 없이 나누어떨어지게 하는 모든 약수를 확인하는 것

** 유클리드 알고리즘
최대공약수를 효율적으로 구할 수 있다
먼저 숫자 x를 다른 숫자 y로 나눈 나머지를 구함
다음에는 나머지를 y,이전단계 y를 x 로 놓고 다시 나눈다
나머지가 0이 될 때까지 반복
나머지가 0이 될 때 나눈 수가 최대공약수

x= 20 y =12 나머지=8
x= 12 y = 8 나머지=4
X= 8 Y=4 나머지=0

최대공약수 4

```go
package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	reader := bufio.NewReader(os.Stdin)
	writer := bufio.NewWriter(os.Stdout)
	defer writer.Flush()

	var t int
	fmt.Fscanln(reader, &t)

	for i := 0; i < t; i++ {
		var a, b int
		fmt.Fscanln(reader, &a, &b)
		fmt.Fprintln(writer, getLCM(a, b))
	}

}

// 최소 공배수 구하기 (유클리드 알고리즘 이용)
func getLCM(first, second int) (lcm int) {
	return first * second / getGCD(first, second) // 두 수의 곱 나누기 최대공약수
}

// 최대 공약수 구하기 (유클리드 알고리즘 이용)
func getGCD(first, second int) (gcd int) {
	if first < second { // fn에 큰 값을 오게 하기
		second, first = first, second
	}

	for second != 0 { // second가 0이 될때까지 반복
		first, second = second, first%second
	}
	return first
}
//출처 https://plein-de-verite.tistory.com/209
```
로그 시간 복잡도
```
package main

import "fmt"

// 유클리드 알고리즘을 사용하여 최대공약수를 계산하는 함수
func findGCD(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}

func main() {
    // 예제로 두 수의 최대공약수를 계산
    num1 := 48
    num2 := 18

    // 함수를 호출하여 최대공약수를 계산
    result := findGCD(num1, num2)

    // 결과 출력
    fmt.Printf("최대공약수(%d, %d): %d\n", num1, num2, result)
}


```


# 소수
자기 자신과 1로만 나누어떨어지는 양의 정수
2,3,5,6,11 등..

소수 판단 함수

//제곱근(square root)이란 간단히 말해 제곱의 반대 개념
주어진 수 n까지 모든 수로 나눠도 소수를 판단하는 데는 문제가 없지만 주어진 수의 제곱근까지만 나누는 것이 더 효율적
왜냐하면 주어진 수 n이 소수가 아닌 경우, 어떤 두 수의 곱으로 나타낼 수 있습니다.
이 두 수 중 하나는 반드시 주어진 수의 제곱근 이하의 값이기 때문에, 그 이상의 수로 나누는 것은 의미가 없습니다.

예를 들어, 16을 판별할 때, 16까지 모든 수로 나눠도 소수 여부를 판단할 수 있습니다.
그러나 효율적인 방법은 4까지만 나누는 것입니다. 왜냐하면 16은 4와 4의 곱으로 나타낼 수 있기 때문입니다.

```
package main

import (
	"fmt"
	"math"
)

// IsPrime 함수는 주어진 숫자가 소수인지 여부를 판단합니다.
func IsPrime(n int) bool {
	if n <= 1 {
		return false
	}
	// 2부터 제곱근까지의 모든 수로 나누어 보며 소수 여부를 판단합니다.
	for i := 2; i <= int(math.Sqrt(float64(n))); i++ {
		if n%i == 0 {
			return false
		}
	}
	return true
}

func main() {
	// 테스트할 숫자를 지정합니다.
	number := 17

	// 주어진 숫자가 소수인지 판단합니다.
	if IsPrime(number) {
		fmt.Printf("%d는 소수입니다.\n", number)
	} else {
		fmt.Printf("%d는 소수가 아닙니다.\n", number)
	}
}

```
다량의 소수를 한꺼번에 판별
```
package main

import "fmt"

// 에라토스테네스의 체 알고리즘을 사용하여 주어진 범위 내의 소수를 찾는 함수
//https://chanhuiseok.github.io/posts/algo-42/
func findPrimes(limit int) []int {
    // 초기화: 모든 수를 소수로 가정
    isPrime := make([]bool, limit+1)
    for i := 2; i <= limit; i++ {
        isPrime[i] = true
    }

    // 에라토스테네스의 체 알고리즘 적용
    for i := 2; i*i <= limit; i++ {
        if isPrime[i] {
            for j := i * i; j <= limit; j += i {
                isPrime[j] = false
            }
        }
    }

    // 소수를 결과 배열에 추가
    primes := []int{}
    for i := 2; i <= limit; i++ {
        if isPrime[i] {
            primes = append(primes, i)
        }
    }

    return primes
}

func main() {
    // 예제로 1부터 50까지의 소수를 찾아봄
    limit := 50
    primeNumbers := findPrimes(limit)

    // 결과 출력
    fmt.Printf("1부터 %d까지의 소수: %v\n", limit, primeNumbers)
}


```