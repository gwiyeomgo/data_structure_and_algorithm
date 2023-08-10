# [슬라이스기반 Queue](https://replit.com/@gwiyeomgo/queue#main.go)
```go
package main

import "fmt"

type Queue struct {
    data []interface{}
}

func (q *Queue) Enqueue(item interface{}) {
    q.data = append(q.data, item)
}
//큐의 가장 앞에 있는 항목을 제거하고 반환
func (q *Queue) Dequeue() interface{} {
    if q.IsEmpty() {
        return nil
    }
    dequeued := q.data[0]
    q.data = q.data[1:]
    return dequeued
}
//메서드는 큐의 가장 앞에 있는 항목(가장 먼저 들어온 항목)을 반환 (삭제 x )
func (q *Queue) Front() interface{} {
    if q.IsEmpty() {
        return nil
    }
    return q.data[0]
}

func (q *Queue) IsEmpty() bool {
    return len(q.data) == 0
}

func (q *Queue) Size() int {
    return len(q.data)
}
```