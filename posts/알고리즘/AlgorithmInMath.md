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
- [피즈버즈](https://leetcode.com/problems/fizz-buzz/submissions/1095757318/) 
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